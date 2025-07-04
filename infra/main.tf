terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "chainlink_net" {
  name                    = var.network_name
  auto_create_subnetworks = true
}


resource "google_compute_firewall" "chainlink_ui" {
  name    = "allow-chainlink-ui"
  network = google_compute_network.chainlink_net.name

  allow {
    protocol = "tcp"
    ports    = ["6688", "6689"]
  }

  source_ranges = [var.source_ranges]
  target_tags   = [var.instance_tags]
}


resource "google_compute_instance" "chainlink_node" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = [var.instance_tags]

  boot_disk {
    initialize_params {
      image = var.instance_image
      size  = var.disk_size
    }
  }

  network_interface {
    network       = google_compute_network.chainlink_net.id
    access_config {}  # gives the VM a public IP
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_key_path)}"
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}