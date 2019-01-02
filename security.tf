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

resource "google_storage_bucket" "spinnaker" {
  name    = "spinnaker-halyard-${random_id.spinnaker_bucket_id.hex}"
  project = "${var.project}"
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_object" "spinnaker-key" {
  bucket = "${google_storage_bucket.spinnaker.name}"
  name = "spinnaker_gcs.json"
  content = "${base64decode(google_service_account_key.spinnaker_sa_key.private_key)}"
}

resource "google_compute_firewall" "allow_spinnaker_gate" {
  name    = "allow-spkr-gate-${var.basename}"
  network = "${var.network}"
  project = "${var.project}"

  allow {
    protocol = "TCP"
    ports    = ["8084"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_spinnaker_deck_ui" {
  name    = "allow-spkr-deck-ui-${var.basename}"
  network = "${var.network}"
  project = "${var.project}"

  allow {
    protocol = "TCP"
    ports    = ["9000"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_spinnaker_jenkins" {
  name    = "allow-spkr-jenkins-${var.basename}"
  network = "${var.network}"
  project = "${var.project}"

  allow {
    protocol = "TCP"
    ports    = ["9090"]
  }

  source_ranges = ["0.0.0.0/0"]
}
