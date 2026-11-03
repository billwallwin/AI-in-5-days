terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "playground-bwallwin-3nza0h"
  region  = "us-central1"
}
