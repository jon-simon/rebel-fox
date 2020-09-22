// Setting up backend
terraform {
  backend "remote" {
    organization = "Jibakurei"
    workspaces {
      name = "cci-challenge5-${var.environment}"
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
