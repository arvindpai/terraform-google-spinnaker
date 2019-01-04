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

output "spinnaker_deck_url" {
  value = "http://${replace(google_dns_record_set.spinnaker_deck_ui_dns.name, "${var.dns_suffix}.", "${var.dns_suffix}")}:9000"
}

output "spinnaker_gate_url" {
  value = "http://${replace(google_dns_record_set.spinnaker_gate_dns.name, "${var.dns_suffix}.", "${var.dns_suffix}")}:8084"
}

output "halyard_config_gcs_bucket" {
  value = "${google_storage_bucket.spinnaker.name}"
}

output "spinnaker_instance_ip" {
  value = "${google_compute_instance.spinnaker.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "spinnaker_service_account" {
  value = "${google_service_account.spinnaker.email}"
}

output "spinnaker_instance_name" {
  value = "${google_compute_instance.spinnaker.name}"
}

output "spinnaker_gate_allow_port" {
  value = "${google_compute_firewall.allow_spinnaker_gate.allow.ports}"
}

output "spinnaker_deck_allow_port" {
  value = "${google_compute_firewall.allow_spinnaker_deck_ui.allow.ports}"
}

output "spinnaker_service_account_key" {
  value = "${google_storage_bucket_object.spinnaker-key.name}"
}

output "spinnaker_instance_zone" {
  value = "${google_compute_instance.spinnaker.zone}"
}