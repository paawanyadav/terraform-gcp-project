provider "google" {
  project     = var.project_id
  credentials = file("credentials.json")
  region      = var.region
}

data "google_compute_zones" "zones" {
  region  = var.region
  project = var.project_id
}

locals {
  type   = ["public", "private"]
  zones = data.google_compute_zones.zones.names
}