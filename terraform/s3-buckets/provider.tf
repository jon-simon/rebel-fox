// Setting up backend
terraform {
  backend "remote" {
    organization = "Jibakurei"
    workspaces {
      name = "s3-bucket-${var.environment}"
    }
  }
}

// Defining the AWS provider
provider "aws" {
  version    = ">= 3.0, < 4.0"
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
