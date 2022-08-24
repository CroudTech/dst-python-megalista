terraform {
  backend "gcs" {
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project
  region  = var.region
  scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control"
  ]
}

data "google_secret_manager_secret_version" "client_id" {
  secret   = "client_id"
  version  = "1"
}

data "google_secret_manager_secret_version" "client_secret" {
  secret   = "client_secret"
  version  = "1"
}

data "google_secret_manager_secret_version" "access_token" {
  secret   = "access_token"
  version  = "1"
}

data "google_secret_manager_secret_version" "refresh_token" {
  secret   = "refresh_token"
  version  = "1"
}

module "megalista" {
  source                     = "github.com/google/megalista//terraform?ref=2127bb8"
  region                     = var.region
  bq_ops_dataset             = var.bq_ops_dataset
  client_id                  = data.google_secret_manager_secret_version.client_id.secret_data
  client_secret              = data.google_secret_manager_secret_version.client_secret.secret_data
  access_token               = data.google_secret_manager_secret_version.access_token.secret_data
  refresh_token              = data.google_secret_manager_secret_version.refresh_token.secret_data
  setup_json_url             = var.config_bucket_name != "" ? "gs://${var.config_bucket_name}/configuration_sample.json" : ""
  setup_firestore_collection = var.setup_firestore_collection
  bucket_name                = var.bucket_name
  developer_token            = var.developer_token
  setup_sheet_id             = var.setup_sheet_id
}

resource "google_storage_bucket" "config_storage" {
  name                        = var.config_bucket_name
  location                    = var.region
  uniform_bucket_level_access = true
}