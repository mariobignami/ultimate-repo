# -------------------------------------------------------------*
# Configure the Google Cloud provider
# -------------------------------------------------------------*
# The provider “google” line indicates that you are using the 
# Google Cloud Terraform provider. To prevent automatic upgrades 
# to new major versions that may contain breaking changes, 
# it is recommended to add version = "..." constraints to the
# corresponding provider blocks in configuration

provider "google" {
  project     = var.project_id
  region      = var.region
  version = ">= 3.78.0"
}

variable "project_name" {
  type = string
  default = "ultimate-app-gcp"
  description = "Service Project Name"
}

variable "google_credentials" {
  description = "Path to the Google Cloud service account key JSON file"
  type        = string
}