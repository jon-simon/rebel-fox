// Setting up backend
terraform {
  backend "remote" {
    organization = "Jibakurei"
    workspaces {
      name = "${var.cluster_id}-${var.name}"
    }
  }
}

// Defining the AWS provider
provider "aws" {
  version    = "~> 2.0"
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
