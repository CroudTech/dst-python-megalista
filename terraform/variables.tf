variable "bucket_name" {
  type        = string
  description = "Google Cloud Storage Bucket to create to hold metadata"
}

variable "bq_ops_dataset" {
  type        = string
  description = "Auxliary bigquery dataset for Megalista operations to create"
}

variable "developer_token" {
  type        = string
  description = "Google Ads developer Token"
}

variable "setup_sheet_id" {
  type        = string
  description = "Setup Sheet Id (leave blank if using JSON or Firestore)"
}

variable "setup_firestore_collection" {
  type        = string
  description = "Setup Firestore collection (leave blank if using JSON or Sheets)"
}

variable "region" {
  type        = string
  description = "GCP region https://cloud.google.com/compute/docs/regions-zones?hl=pt-br default us-central1"
}

variable "project" {
  type        = string
  description = "GCP Project name"
}

variable "config_bucket_name" {
  type        = string
  description = "Google Cloud Storage Bucket to create to keep the config"
}
