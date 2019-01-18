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

provider google {
  version = "~> 1.20"
  project = "${var.project}"
  region  = "${var.region}"
}

provider "random" {
  version = "~> 2.0"
}

resource "random_string" "suffix" {
  length  = 8
  upper   = false
  lower   = true
  number  = true
  special = false
}

locals {
  random_suffix = "${random_string.suffix.result}"
  resource_name = "spinnaker-minimal-${local.random_suffix}"
  labels        = {}
}

resource "google_compute_network" "test" {
  name                    = "${local.resource_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "test" {
  name          = "${local.resource_name}"
  network       = "${google_compute_network.test.name}"
  region        = "${var.region}"
  ip_cidr_range = "10.2.0.0/16"
}

resource "google_service_account" "test" {
  account_id = "${local.resource_name}"
}

resource "google_project_iam_member" "test" {
  role   = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${google_service_account.test.email}"
}

resource "google_dns_managed_zone" "test" {
  name     = "${local.resource_name}"
  dns_name = "${local.resource_name}.com."
  labels   = "${local.labels}"
}

module "test" {
  source                = "../../../examples/minimal/"
  project               = "${var.project}"
  region                = "${var.region}"
  zone_dns_name         = "${google_dns_managed_zone.test.dns_name}"
  zone_name             = "${google_dns_managed_zone.test.name}"
  labels                = {}
  service_account_email = "${google_service_account.test.email}"
}
