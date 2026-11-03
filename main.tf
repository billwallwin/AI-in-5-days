# [Section 5: Infrastructure & CI/CD] - Terraform IaC Configuration
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

resource "google_cloud_run_v2_service" "copilot_service" {
  name     = "gsf-copilot-service"
  location = "us-central1"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"

  template {
    containers {
      image = "us-central1-docker.pkg.dev/playground-bwallwin-3nza0h/cloud-run-source-deploy/copilot-image:latest"
      
      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = "playground-bwallwin-3nza0h"
      }
      env {
        name  = "GEMINI_API_KEY"
        value = "secret"
      }
    }
  }
}
