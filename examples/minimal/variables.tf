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
  description = ""
  default     = ""
}

variable "zone_dns_name" {
  description = ""
  default     = "example.com."
}

variable "zone_name" {
  description = ""
  default     = "example-com-zone"
}

variable "labels" {
  description = "description"
  default     = {}
}

variable "project" {
  description = "description"
}

variable "region" {
  description = ""
}

variable "service_account_email" {
  description = "description"
  default     = ""
}
