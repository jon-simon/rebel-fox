// niles kubernetes cluster workspaces
module "webserver" {
  source            = "app.terraform.io/jibakurei/workspace/tfe"
  workspace_name    = "webserver"
  name              = "jibakurei"
  environment       = "dev"
  cluster_id        = "daphne"
  operator          = "circle"
  org               = "jibakurei"
  working_directory = "/terraform/poc-webservers"
  github_repo       = "jon-simon/rebel-fox"
  branch            = "master"
  aws_access_key    = var.aws_access_key_id
  aws_secret_key    = var.aws_secret_access_key
  aws_account_name  = "jibakurei"
  oauth_token_id    = var.oauth_token_id
}
