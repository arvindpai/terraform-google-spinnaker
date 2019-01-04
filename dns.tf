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

resource "google_dns_record_set" "spinnaker_deck_ui_dns" {
  managed_zone = "${var.dns_zone}"
  name         = "spin-fe.${var.basename}.${var.dns_suffix}."
  project      = "${var.project}"
  rrdatas      = ["${google_compute_instance.spinnaker.network_interface.0.access_config.0.assigned_nat_ip}"]
  ttl          = 0
  type         = "A"
}

resource "google_dns_record_set" "spinnaker_gate_dns" {
  managed_zone = "${var.dns_zone}"
  name         = "spin-gate.${var.basename}.${var.dns_suffix}."
  project      = "${var.project}"
  rrdatas      = ["${google_compute_instance.spinnaker.network_interface.0.access_config.0.assigned_nat_ip}"]
  ttl          = 0
  type         = "A"
}

resource "google_dns_record_set" "spinnaker_jenkins_dns" {
  managed_zone = "${var.dns_zone}"
  name         = "spin-jenkins.${var.basename}.${var.dns_suffix}."
  project      = "${var.project}"
  rrdatas      = ["${google_compute_instance.spinnaker.network_interface.0.access_config.0.assigned_nat_ip}"]
  ttl          = 0
  type         = "A"
}
