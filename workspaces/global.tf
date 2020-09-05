// Workspaces
module "ec2_keypairs" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  version = "0.1.0"
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
