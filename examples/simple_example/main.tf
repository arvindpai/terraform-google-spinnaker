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
  source              = "../../"
  project             = "${var.project_id}"
  dns_zone            = "${var.dns_zone}"
  dns_suffix          = "${var.dns_suffix}"
  network             = "${var.network}"
  region              = "${var.region}"
  jenkins_username    = "spin-admin"
  jenkins_port        = "9090"
  jenkins_master_name = "spin-jenkins"
  jenkins_password    = "xxxxxxx"
  basename            = "${var.environment}"
  ansible_basedir     = "${var.ansible_basedir}"
  zone                = "us-central1-a"
  machine_type        = "n1-standard-4"
}
