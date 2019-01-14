resource "random_id" "spinnaker_bucket_id" {
  byte_length = 6
}

resource "null_resource" "ansible_sync" {
  provisioner "local-exec" {
    command = "gsutil cp -R ${var.ansible_basedir} gs://${google_storage_bucket.spinnaker.name}/"
  }

  depends_on = ["google_storage_bucket.spinnaker"]
}

resource "google_compute_instance" "spinnaker" {
  name                    = "spkr-gce-${var.basename}"
  machine_type            = "${var.machine_type}"
  zone                    = "${var.zone}"
  project                 = "${var.project}"
  metadata_startup_script = "${data.template_file.startup_script_spinnaker.rendered}"

  boot_disk {
    initialize_params {
      image = "ubuntu-1404-trusty-v20181114"
      size  = "60"
    }
  }

  network_interface {
    network       = "${var.network}"
    access_config = {}
  }

  metadata {
    hostname = "spkr-gce-${var.basename}"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
  }
}
