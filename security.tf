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

resource "google_storage_bucket" "main" {
  name          = "spinnaker-halyard-${var.project}"
  project       = "${var.project}"
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_object" "main_key" {
  bucket  = "${google_storage_bucket.main.name}"
  name    = "spinnaker_gcs.json"
  content = "${base64decode(google_service_account_key.main_sa_key.private_key)}"
}

resource "google_compute_firewall" "allow_gate" {
  name    = "allow-spkr-gate-${var.resource_name}"
  network = "${data.google_compute_network.main.name}"
  project = "${var.project}"

  allow {
    protocol = "TCP"
    ports    = ["8084"]
  }

  source_ranges = ["${var.protected_networks}"]
}

resource "google_compute_firewall" "allow_deck_ui" {
  name    = "allow-spkr-deck-ui-${var.resource_name}"
  network = "${data.google_compute_network.main.name}"
  project = "${var.project}"

  allow {
    protocol = "TCP"
    ports    = ["9000"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_jenkins" {
  name    = "allow-spkr-jenkins-${var.resource_name}"
  network = "${data.google_compute_network.main.name}"
  project = "${var.project}"

  allow {
    protocol = "TCP"
    ports    = ["9090"]
  }

  source_ranges = ["0.0.0.0/0"]
}
