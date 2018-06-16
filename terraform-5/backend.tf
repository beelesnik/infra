terraform {
  backend "gcs" {
    bucket  = "tf-state-prod-lsn"
    prefix  = "terraform/state"
  }
}
