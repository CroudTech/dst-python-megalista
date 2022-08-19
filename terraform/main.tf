terraform {
  backend "gcs" {
    bucket  = var.state_bucket_name
    prefix  = "terraform/state"
  }
}

module "megalista"{
    source = "github.com/google/megalista//terraform?ref=2127bb8"
}