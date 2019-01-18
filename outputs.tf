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

output "gate_allow_port" {
  description = "Spinnaker Gate API TCP Port"
  value       = "${google_compute_firewall.allow_gate.allow.ports}"
}

# output "deck_url" {
#   value = "http://${replace(google_dns_record_set.deck.name, "${var.zone_dns_name}.", "${var.zone_dns_name}")}:9000"
# }

# output "gate_url" {
#   value = "http://${replace(google_dns_record_set.gate.name, "${var.zone_dns_name}.", "${var.zone_dns_name}")}:8084"
# }

output "halyard_config_gcs_bucket" {
  description = "GCS Bucket where Halyard Configs and Persistent storage is defined"
  value       = "${google_storage_bucket.main.name}"
}

output "instance_ip" {
  description = "GCE Instance IP Address for Spinnaker"
  value       = "${google_compute_instance.main.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "instance_name" {
  description = "Spinnaker GCE Instance name"
  value       = "${google_compute_instance.main.name}"
}

output "service_account" {
  description = "Spinnaker Service account that is used to create GCP resources"
  value       = "${google_service_account.main.email}"
}

output "deck_allow_port" {
  description = "Spinnaker Deck UI TCP Port"
  value       = "${google_compute_firewall.allow_deck_ui.allow.ports}"
}

output "service_account_key_name" {
  description = "Spinnaker service account key"
  value       = "${google_storage_bucket_object.main_key.name}"
}
