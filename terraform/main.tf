terraform {
  backend "gcs" {
    bucket  = "croud_dev_pvt_megalista_terraform_state"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project     = var.project
  region        = var.region
      scopes = [
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
        "https://www.googleapis.com/auth/devstorage.full_control"
    ]
}

module "megalista"{
    source = "github.com/google/megalista//terraform?ref=2127bb8"
    region = var.region
    bq_ops_dataset = var.bq_ops_dataset
    client_id = var.client_id
    client_secret = var.client_secret
    access_token = var.access_token
    setup_json_url = var.setup_json_url
    setup_firestore_collection = var.setup_firestore_collection
    bucket_name = var.bucket_name
    developer_token = var.developer_token
    refresh_token = var.refresh_token
    setup_sheet_id = var.setup_sheet_id
}