terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project     = "infoline-devops-hiver2025"
  region      = "us-central1"
  credentials = file("key.json")
}
