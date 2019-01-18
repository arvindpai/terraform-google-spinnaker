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

locals {
  network_project       = "${var.network_project == "" ? var.project : var.network_project}"
  primary_zone          = "${var.primary_zone == "" ? data.google_compute_zones.available.names[0] : var.primary_zone}"
  secondary_zone        = "${var.secondary_zone == "" ? data.google_compute_zones.available.names[1] : var.secondary_zone}"
  service_account_email = "${var.service_account_email}"
}

data "google_compute_network" "main" {
  name    = "${var.network_name}"
  project = "${local.network_project}"
}

data "google_compute_subnetwork" "main" {
  name    = "${var.subnetwork_name}"
  project = "${local.network_project}"
  region  = "${var.region}"
}

data "google_compute_zones" "available" {
  project = "${var.project}"
  region  = "${var.region}"
}

data "google_compute_image" "name" {
  project = "${var.image_name == "" ? "ubuntu-os-cloud" : var.image_project}"
  name    = "${var.image_name == "" ? "ubuntu-1604-xenial-v20190112" : var.image_name}"
}

data "google_compute_image" "family" {
  project = "${var.image_family == "" ? "ubuntu-os-cloud" : var.image_project}"
  family  = "${var.image_family == "" ? "ubuntu-1604-lts" : var.image_family}"
}

# data "template_file" "startup_script" {
#   template = "${file("${path.module}/scripts/bootstrap.sh")}"


#   vars {
#     gcp_project_id            = "${var.project}"
#     gcp_region                = "${var.region}"
#     spinnaker_deck_url        = "http://spinnaker-fe.${var.resource_name}.${var.zone_dns_name}:9000"
#     spinnaker_api_url         = "http://spinnaker-gate.${var.resource_name}.${var.zone_dns_name}:8084"
#     spinnaker_gcs_bucket_name = "${google_storage_bucket.main.name}"
#   }
# }

