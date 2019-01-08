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


output "spinnaker_vm_zone" {
  description = "GCP Availability Zone"
  value = "${module.spinnaker.spinnaker_instance_zone}"
}

output "spinnaker_instance_name" {
  description = "Spinnaker GCE Instance Name"
  value = "${module.spinnaker.spinnaker_instance_name}"
}

output "spinnaker_deck_url" {
  description = "Spinnker Frontend URL"
  value = "${module.spinnaker.spinnaker_deck_url}"
}

output "spinnaker_gate_url" {
  description = "Spinnaker Gate API URL"
  value = "${module.spinnaker.spinnaker_gate_url}"
}

output "spinnaker_halyard_bucket" {
  description = "Halyard configuration GCS Bucket"
  value = "${module.spinnaker.halyard_config_gcs_bucket}"
}
