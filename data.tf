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

data "template_file" "startup_script_spinnaker" {
  template = "${file("${path.module}/scripts/bootstrap.sh")}"

  vars {
    gcp_project_id       = "${var.project}"
    gcp_region           = "${var.region}"
    spin_deck_url        = "http://spin-fe.${var.basename}.${var.dns_suffix}:9000"
    spin_api_url         = "http://spin-gate.${var.basename}.${var.dns_suffix}:8084"
    jenkins_master_name  = "${var.jenkins_master_name}"
    jenkins_master_url   = "http://spin-jenkins.${var.basename}.${var.dns_suffix}:${var.jenkins_port}"
    jenkins_username     = "${var.jenkins_username}"
    jenkins_password     = "${var.jenkins_password}"
    spin_gcs_bucket_name = "${google_storage_bucket.spinnaker.name}"
    spin_environment     = "dev"
  }
}
