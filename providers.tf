# -------------------------------------------------------------*
# Configure the Google Cloud provider
# -------------------------------------------------------------*
# The provider “google” line indicates that you are using the 
# Google Cloud Terraform provider. To prevent automatic upgrades 
# to new major versions that may contain breaking changes, 
# it is recommended to add version = "..." constraints to the
# corresponding provider blocks in configuration
//provider "google" {
//    credentials = file("creds.json")
//    project     = "ultimate-app-gcp"
//    region      = "us-central1"
//}



provider "google" {
    credentials = file("terraform-gcp-auth.json")
    project = var.project_name
}

variable "project_name" {
  type = string
  default = "ultimate-app-gcp"
  description = "Service Project Name"
}