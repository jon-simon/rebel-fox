// To avoid duplication all locals should be defined in this file
locals {
  operator     = var.operator
  name         = var.name
  service_name = "kubernetes"
  environment  = var.environment
  subnets = sort(cidrsubnets(var.cidr_block, 12, 12, 12, 6, 6, 6, 12, 12, 12))

  common_tags = {
    Service     = local.service_name
    Owner       = local.operator
    Environment = local.environment
    Provisioner = "terraform"
  }
}
