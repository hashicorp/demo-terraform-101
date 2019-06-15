provider "google" {
  project = "my-google-cloud-project"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  labels = {
    billing_department = "education"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }

  metadata_startup_script = "echo 'Hello Terraform on GCP!' > index.html; python -m SimpleHTTPServer 9000 &"
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "default" {
  name    = "terraform-firewall"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["9000"]
  }
}

output "private_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].network_ip
}

output "website_url" {
  value = "http://${google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip}:9000"
}

