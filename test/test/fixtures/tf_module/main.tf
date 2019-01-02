/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {
  credentials = "${file(var.credentials_path)}"
}

module "spinnaker" {
  source              = "../../../"
  project             = "${var.project_id}"
  dns_zone            = "gcloud-rootleveltech-com"
  dns_suffix          = "gcloud.rootleveltech.com"
  network             = "${var.network}"
  region              = "${var.region}"
  jenkins_username    = "spin-admin"
  jenkins_port        = "9090"
  jenkins_master_name = "spin-jenkins"
  jenkins_password    = "testing"
  basename = "eff"
  gce_ssh_pub_key_file = "${var.gce_ssh_pub_key_file}"
  gce_ssh_user = "${var.gce_ssh_user}"
}
