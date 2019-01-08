# encoding: utf-8
# copyright: 2018, The Authors

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

title 'Spinnaker Terraform GCP Test Suite'

gcp_project_id = attribute('gcp_project_id')


control 'spinnaker-vm' do
  impact 1.0
  title 'Test spinnaker client vm'
  describe google_compute_instances(project: gcp_project_id,  zone: 'us-central1-a') do
    its('instance_names') { should include /spkr-gce-integration/ }
  end
end


control 'spinnaker-service-account-iam-roles' do
  gcp_enable_privileged_resources = '1'

  impact 1.0
  title 'Test Spinnaker Project IAM Role bindings'
  describe google_project_iam_binding(project: gcp_project_id, role: "roles/compute.instanceAdmin") do
    it { should exist }
    its ('members'){ should include /spinnaker-halyard/ }
  end
  describe google_project_iam_binding(project: gcp_project_id, role: "roles/compute.networkAdmin") do
    it { should exist }
    its ('members'){ should include /spinnaker-halyard/ }
  end
  describe google_project_iam_binding(project: gcp_project_id, role: "roles/compute.securityAdmin") do
    it { should exist }
    its ('members'){ should include /spinnaker-halyard/ }
  end
  describe google_project_iam_binding(project: gcp_project_id, role: "roles/compute.storageAdmin") do
    it { should exist }
    its ('members'){ should include /spinnaker-halyard/ }
  end
  describe google_project_iam_binding(project: gcp_project_id, role: "roles/storage.admin") do
    it { should exist }
    its ('members'){ should include /spinnaker-halyard/ }
  end
  describe google_project_iam_binding(project: gcp_project_id, role: "roles/owner") do
    it { should exist }
    its ('members'){ should include /spinnaker-halyard/ }
  end
end

control 'spinnaker-google-storage-buckets' do
  impact 1.0
  title 'Test GCS Buckets are present'
  describe google_storage_buckets(project: gcp_project_id) do
    its('bucket_names') { should include /spinnaker-halyard/ }
  end
  # @TODO can't get the bucket to accept regex matching, below works but doesn't account for random_id
  # describe google_storage_bucket_objects(bucket: 'spinnaker-server-52d2853a') do
  #   its('object_names'){ should include 'configs/spinnaker_conf_server.yaml' }
  # end
end

control 'spinnaker-halyard-service-account' do
  impact 1.0
  title 'Test spinnaker halyard Service Account'
  describe google_service_accounts(project: gcp_project_id) do
    its('service_account_emails'){ should include /spinnaker-halyard/ }
  end
end

control 'spinnaker-firewall-rules' do
  impact 1.0
  title 'Test spinnaker Firewall Rules'
  describe google_compute_firewalls(project: gcp_project_id) do
    its('firewall_names') { should include /allow-spkr-gate/ }
  end
  describe google_compute_firewalls(project: gcp_project_id) do
    its('firewall_names') { should include /allow-spkr-deck-ui/ }
  end
  describe google_compute_firewalls(project: gcp_project_id) do
    its('firewall_names') { should include /allow-spkr-jenkins/ }
  end

end

