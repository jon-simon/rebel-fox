// Workspaces with Global resources that will be shared across all Kubernetes clusters
module "kubernetes-vpc" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  workspace_name    = "kubernetes-vpc"
  name              = "jibakurei"
  environment       = "global"
  operator          = "jibakurei"
  org               = "jibakurei"
  working_directory = "/terraform/kubernetes-vpc"
  github_repo       = "jon-simon/rebel-fox"
  branch            = "master"
  aws_access_key    = var.aws_access_key_id
  aws_secret_key    = var.aws_secret_access_key
  aws_account_name  = "jibakurei"
  oauth_token_id    = var.oauth_token_id
}

module "image-builder-vpc" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  workspace_name    = "image-builder-vpc"
  name              = "jibakurei"
  environment       = "global"
  operator          = "jibakurei"
  org               = "jibakurei"
  working_directory = "/terraform/image-builder-vpc"
  github_repo       = "jon-simon/rebel-fox"
  branch            = "master"
  aws_access_key    = var.aws_access_key_id
  aws_secret_key    = var.aws_secret_access_key
  aws_account_name  = "jibakurei"
  oauth_token_id    = var.oauth_token_id
}

module "hosted-zones" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  workspace_name    = "hosted-zones"
  name              = "jibakurei"
  environment       = "global"
  operator          = "jibakurei"
  org               = "jibakurei"
  working_directory = "/terraform/hosted-zones"
  github_repo       = "jon-simon/rebel-fox"
  branch            = "master"
  aws_access_key    = var.aws_access_key_id
  aws_secret_key    = var.aws_secret_access_key
  aws_account_name  = "jibakurei"
  oauth_token_id    = var.oauth_token_id
}

module "ec2-keypairs" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  workspace_name    = "ec2-keypairs"
  name              = "jibakurei"
  environment       = "global"
  operator          = "jibakurei"
  org               = "jibakurei"
  working_directory = "/terraform/ec2-keypairs"
  github_repo       = "jon-simon/rebel-fox"
  branch            = "master"
  aws_access_key    = var.aws_access_key_id
  aws_secret_key    = var.aws_secret_access_key
  aws_account_name  = "jibakurei"
  oauth_token_id    = var.oauth_token_id
}

module "s3-buckets" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  workspace_name    = "s3-buckets"
  name              = "jibakurei"
  environment       = "global"
  operator          = "jibakurei"
  org               = "jibakurei"
  working_directory = "/terraform/s3-buckets"
  github_repo       = "jon-simon/rebel-fox"
  branch            = "master"
  aws_access_key    = var.aws_access_key_id
  aws_secret_key    = var.aws_secret_access_key
  aws_account_name  = "jibakurei"
  oauth_token_id    = var.oauth_token_id
}

module "cci-challenge5" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  workspace_name    = "cci-challenge5"
  name              = "jibakurei"
  environment       = "global"
  operator          = "jibakurei"
  org               = "jibakurei"
  working_directory = "/terraform/cci-challenge5"
  github_repo       = "jon-simon/rebel-fox"
  branch            = "master"
  aws_access_key    = var.aws_access_key_id
  aws_secret_key    = var.aws_secret_access_key
  aws_account_name  = "jibakurei"
  oauth_token_id    = var.oauth_token_id
}
