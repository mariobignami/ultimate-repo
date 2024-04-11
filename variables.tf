variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
  default = "ultimate-app-gcp"
  
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The Google Cloud zone"
  type        = string
  default     = "us-central1-c"
}

variable "cluster_name" {
  description = "The Google Cloud Kubernetes cluster name"
  type        = string
  default     = "node-demo-k8s"
}

provider "google" {
    credentials = "${var.google_credentials}"
}

variable "google_credentials" {
    default = "${env("GOOGLE_CREDENTIALS")}"
}

