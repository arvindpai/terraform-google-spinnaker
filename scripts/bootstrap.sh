#!/bin/bash
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -x

# Setup explicit logging for the installation / startup script so it can be referenced later.
exec > >(tee /var/log/start-script.log | logger -t user-data -s 2>/dev/console) 2>&1

# All the hostname corrections. The first thing that should happen.
MY_HOSTNAME=$(curl --silent "http://metadata.google.internal/computeMetadata/v1/instance/attributes/hostname" -H "Metadata-Flavor: Google")
sudo echo '@reboot hostname $(curl --silent "http://metadata.google.internal/computeMetadata/v1/instance/attributes/hostname" -H "Metadata-Flavor: Google")' >/tmp/set_hostname.sh
sudo crontab -u root /tmp/set_hostname.sh
hostname $MY_HOSTNAME
hostnamectl set-hostname $MY_HOSTNAME
MY_DOMAIN=$(hostname -d)
if [ -z "$(grep $MY_DOMAIN /etc/hosts)" ]; then
  # We need to make sure that /etc/hosts is consistent, else IDM deployment will fail
  IP=$(hostname -I | awk {'print $1'})
  sed -i 's|'"$IP .*internal"'|'"$IP $MY_HOSTNAME "'|' /etc/hosts
  # Note, the internal. is the internal internal GCP default domain.
fi
rm -f /etc/dhcp/dhclient-exit-hooks.d/google_set_hostname

sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update && apt-get upgrade -y
sudo apt-get install software-properties-common -y
sudo apt-get install ansible -y

sudo cat >/tmp/spinnaker_roles.yml <<EOF
---
- hosts: localhost
  remote_user: root
  roles:
    - spinnaker-halyard
EOF

sudo cat >/tmp/spinnaker_defaults.yml <<EOF
---
spinnaker_halyard_installation_script_url: "https://raw.githubusercontent.com/rootleveltech/spinnaker-halyard/master/InstallHalyard.sh"
hal_user: halyard
hal_version: "1.11.2"
spinnaker_project_id: "${project_id}"
spinnaker_deck_url: "${spinnaker_deck_url}"
spinnaker_api_url: "${spinnaker_api_url}"
spinnaker_environment: "${spinnaker_environment}"

#front50_service_account_name: "spinnaker-test"
#Group name in gsuite. if defined more than one,
#user who can list this spinnaker service account must belong to all groups defined
#front50_service_account_member: '["spinnaker"]'
#spinnaker_oauth_client_id: "oauth_client_id"
#spinnaker_oauth_client_secret: "oauth_client_secret"
#spinnaker_oauth_provider: "google"
#spinnaker_gsuite_admin_username: "admin@testspinnaker.com"
#spinnaker_gsuite_domain: "testspinnaker.com"
#spinnaker_slack_bot_name: "slackbot"
#spinnaker_slack_token: "xxxxxxxxxxxxxxxxx"


jenkins_master_name: "${jenkins_master_name}"
jenkins_base_url: "${jenkins_master_url}"
jenkins_username: "${jenkins_username}"
jenkins_user_password: "${jenkins_password}"

spinnaker_gcs_bucket_location: "${gcp_region}"
spinnaker_gcs_bucket_name: "${spinnaker_gcs_bucket_name}"
spinnaker_service_account_filename: "spinnaker-halyard"
EOF

mkdir -p /tmp/roles

gsutil cp -R gs://${spinnaker_gcs_bucket_name}/spinnaker-halyard /tmp/roles/
gsutil cp -R gs://${spinnaker_gcs_bucket_name}/spinnaker_gcs.json /tmp/spinnaker_gcs.json
mkdir -p /tmp/roles/spinnaker-halyard/defaults
cp /tmp/spinnaker_defaults.yml /tmp/roles/spinnaker-halyard/defaults/main.yml

ansible-playbook /tmp/spinnaker_roles.yml --connection=local -i /tmp/roles/spinnaker-halyard/tests/inventory
