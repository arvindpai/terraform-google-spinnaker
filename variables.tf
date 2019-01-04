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

variable "project" {}
variable "machine_type" {}

variable "dns_zone" {}

variable "dns_suffix" {}

variable "region" {}
variable "zone" {}

variable "network" {
  default = "default"
}

variable "jenkins_master_name" {}
variable "jenkins_username" {}
variable "jenkins_password" {}
variable "jenkins_port" {}

# Required for Ansible configuration
variable "ansible_basedir" {}

# rip this out
variable "basename" {}
