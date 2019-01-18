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
resource "google_dns_record_set" "deck" {
  name         = "spinnaker-fe.${var.resource_name}.${var.zone_dns_name}"
  project      = "${var.project}"
  managed_zone = "${var.zone_name}"
  rrdatas      = ["${google_compute_instance.main.network_interface.0.access_config.0.assigned_nat_ip}"]
  ttl          = 300
  type         = "A"
}

resource "google_dns_record_set" "gate" {
  name         = "spinnaker-gate.${var.resource_name}.${var.zone_dns_name}"
  project      = "${var.project}"
  managed_zone = "${var.zone_name}"
  rrdatas      = ["${google_compute_instance.main.network_interface.0.access_config.0.assigned_nat_ip}"]
  ttl          = 300
  type         = "A"
}
