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

variable "project" {
  description = "GCP Project that Spinnaker will be deployed within"
}

variable "machine_type" {
  description = "GCE Instance size that the spinnaker instance(s) will be provisioned with."
}

variable "dns_zone" {
  description = "DNS Zone that will be used to create the Spinnaker service entries"
}

variable "dns_suffix" {
  description = "The DNS suffix to create the actual records"
}

variable "region" {
  description = "GCP Region that resources will be deployed into"
}

variable "zone" {
  description = "GCP Availability Zones that the instnaces will be deployed within"
}

variable "network" {
  description = ""
  default     = "default"
}

variable "protected_networks" {
  description = "The network CIDRs that will have access to Spinnaker"
  type        = "list"
}

variable "jenkins_master_name" {
  description = "Spinnaker resource name for the Jenkins Server you want to register"
}

variable "jenkins_username" {
  description = "Jenkins username to connect to the instance that you defined above"
}

variable "jenkins_password" {
  description = "Jenkins password for the username defined in the jenkins_username"
}

variable "jenkins_port" {
  description = "TCP port that Jenkins is running on"
}

# Required for Ansible configuration
variable "ansible_basedir" {
  description = "This is the location of the ansible playbook on the local disk for the null resource to copy to the GCS bucket"
}

# rip this out
variable "basename" {}
