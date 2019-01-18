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

# # TODO: put this through terraform resources
# resource "null_resource" "ansible_sync" {
#   provisioner "local-exec" {
#     command = "gsutil cp -R ${var.ansible_basedir} gs://${google_storage_bucket.main.name}/"
#   }

#   depends_on = ["google_storage_bucket.main"]
# }

resource "google_project_service" "main" {
  count              = "${length(var.activate_apis)}"
  project            = "${var.project}"
  service            = "${element(var.activate_apis, count.index)}"
  disable_on_destroy = "${var.disable_services_on_destroy}"
}

#TODO: revisit as a managed instance group
resource "google_compute_instance" "main" {
  name         = "${var.resource_name}"
  machine_type = "${var.machine_type}"
  zone         = "${local.primary_zone}"
  project      = "${var.project}"

  # metadata_startup_script = "${data.template_file.startup_script.rendered}"

  boot_disk {
    initialize_params {
      image = "${var.image_family == "" ? data.google_compute_image.name.self_link : data.google_compute_image.family.self_link}"
      size  = "${var.boot_disk_size}"
      type  = "pd-standard"
    }
  }
  # TODO: verify network_interface settings
  network_interface {
    network       = "${data.google_compute_network.main.name}"
    access_config = {}
  }
  # TODO: unsure what this is used for
  metadata {
    hostname = "spkr-gce-${var.resource_name}"
  }
  # metadata = "${var.instance_metadata}"
  service_account {
    email  = "${local.service_account_email}"
    scopes = "${var.service_account_scopes}"
  }
  labels = "${var.labels}"
}

resource "google_redis_instance" "main" {
  name    = "${var.resource_name}"
  project = "${var.project}"
  region  = "${var.region}"

  #TODO: test if these attributes work when not in STANDARD_HA
  location_id             = "${local.primary_zone}"
  alternative_location_id = "${local.secondary_zone}"
  authorized_network      = "${data.google_compute_network.main.name}"
  display_name            = "${var.resource_name}"
  memory_size_gb          = "${var.redis_memory_size_gb}"
  redis_version           = "REDIS_3_2"
  tier                    = "${var.redis_service_tier}"
  labels                  = "${var.labels}"
  redis_configs           = "${var.redis_configs}"

  # reserved_ip_range = ""
}
