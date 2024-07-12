terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.23.0"
    }

    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}

provider "google" {
  project = local.project
  region  = local.region
  zone    = local.zone
}

locals {
  project         = "changelog-twitter-poster"
  project_id      = "changelog-twitter-poster"
  project_num     = "157958522731"
  region          = "us-west1"
  zone            = "us-west1-b"
  bucket_location = "US-WEST1"
}

resource "google_storage_bucket" "staging_bucket" {
  name          = "${local.project}-cloud-function-staging"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}