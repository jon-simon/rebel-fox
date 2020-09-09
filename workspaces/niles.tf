// niles kubernetes cluster workspaces
module "control-plane" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  workspace_name    = "control-plane"
  name              = "jibakurei"
  environment       = "dev"
  cluster_id        = "niles"
  operator          = "circle"
  org               = "jibakurei"
  working_directory = "/terraform/control-plane"
  github_repo       = "jon-simon/rebel-fox"
  branch            = "master"
  aws_access_key    = var.aws_access_key_id
  aws_secret_key    = var.aws_secret_access_key
  aws_account_name  = "jibakurei"
  oauth_token_id    = var.oauth_token_id
}

module "worker" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  workspace_name    = "worker"
  name              = "jibakurei"
  environment       = "dev"
  cluster_id        = "niles"
  operator          = "circle"
  org               = "jibakurei"
  working_directory = "/terraform/worker"
  github_repo       = "jon-simon/rebel-fox"
  branch            = "master"
  aws_access_key    = var.aws_access_key_id
  aws_secret_key    = var.aws_secret_access_key
  aws_account_name  = "jibakurei"
  oauth_token_id    = var.oauth_token_id
}
