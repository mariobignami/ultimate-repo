variable "HMAC_ACCESS_KEY" {
  description = "The HMAC access key for GCP"
  type        = string
}

variable "HMAC_SECRET" {
  description = "The HMAC secret for GCP"
  type        = string
  sensitive   = true
}

variable "GCP_CREDENTIALS" {
  description = "The value of the GCP credentials file in JSON format"
  type        = string
}
provider "google" {
  credentials = file(var.GCP_CREDENTIALS)
  project     = "ultimate-app-gcp"
  region      = "us-central1"
}

resource "google_container_cluster" "primary" {
  name               = "node-demo-k8s"  # cluster name
  location           = "us-central1-c"
  initial_node_count = 4               # number of node (VMs) for the cluster

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials node-demo-k8s --zone us-central1-c --project ultimate-app-gcp"
  }

  node_config {
    preemptible  = true
    machine_type = "e2-micro"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    tags = ["node-demo-k8s"]
  }

  timeouts {
    create = "45m" 
    update = "60m"
  }
}

resource "google_compute_firewall" "nodeports" {
  name    = "node-port-range"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30000-32767", "80", "443", "8080", "22"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}