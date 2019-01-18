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

variable "ansible_basedir" {
  description = "This is the location of the ansible playbook on the local disk for the null resource to copy to the GCS bucket"
}

variable "boot_disk_size" {
  description = "Size of the spinnaker instance boot disk."
  default     = "60"
}

variable "disable_services_on_destroy" {
  description = "This option informs whether `google_project_service` resources to attempt disable APIs in the case tha this module is destroyed."
  default     = "false"
}

variable "zone_name" {
  description = "DNS Zone that will be used to create the Spinnaker service entries"
}

variable "zone_dns_name" {
  description = "Must include trailing period (.)"
}

variable "activate_apis" {
  description = ""
  type        = "list"
  default     = ["redis.googleapis.com", "compute.googleapis.com", "dns.googleapis.com"]
}

variable "image_family" {
  description = "description"
  default     = ""
}

variable "image_name" {
  description = "description"
  default     = ""
}

variable "image_project" {
  description = "description"
  default     = ""
}

variable "instance_metadata" {
  description = "description"
  default     = {}
}

variable "labels" {
  description = "description"
  default     = {}
}

variable "machine_type" {
  description = "The size of the spinnaker instance."
  default     = "n1-standard-4"
}

variable "network_name" {
  description = "description"
  default     = "default"
}

variable "network_project" {
  description = "description"
  default     = ""
}

variable "primary_zone" {
  description = "description"
  default     = ""
}

variable "project" {
  description = "Project in which resources will be created."
}

variable "protected_networks" {
  description = "The network CIDRs that will have access to Spinnaker"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "service_account_email" {
  description = "description"
  default     = ""
}

variable "service_account_scopes" {
  description = "description"
  type        = "list"
  default     = ["userinfo-email", "compute-ro", "storage-rw"]
}

variable "redis_configs" {
  description = "description"
  default     = {}

  # TODO: how to structure this? https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs
}

variable "redis_memory_size_gb" {
  description = "description"
  default     = "1"
}

variable "redis_service_tier" {
  description = "description"
  default     = "STANDARD_HA"
}

variable "region" {
  description = "The region resources will be deployed into"
}

variable "resource_name" {
  description = "The name given to all resources."
  default     = "spinnaker"
}

variable "secondary_zone" {
  description = "description"
  default     = ""
}

variable "subnetwork_name" {
  description = "description"
  default     = "default"
}
