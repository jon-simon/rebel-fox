// To avoid duplication all locals should be defined in this file
locals {
  operator         = var.operator
  name             = var.name
  aws_account_name = var.aws_account_name
  service_name     = "${local.name}-${local.cluster_id}"
  environment      = var.environment
  cluster_id       = var.cluster_id
  azs              = sort(data.aws_availability_zones.in_use.names)

  common_tags = {
    Service         = local.service_name
    Owner           = local.operator
    ChefEnvironment = local.environment
    ClusterID       = local.cluster_id
    Origin          = "Terraform"
    AccountName     = local.aws_account_name
  }
}
