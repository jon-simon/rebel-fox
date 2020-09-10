// To avoid duplication all locals should be defined in this file
locals {
  operator     = var.operator
  name         = var.name
  service_name = "kubernetes"
  environment  = var.environment
  subnets = sort(cidrsubnets(var.cidr_block, 12, 12, 12, 4, 4, 4, 12, 12, 12))

  common_tags = {
    Service     = local.service_name
    Owner       = local.operator
    Environment = local.environment
    Provisioner = "terraform"
  }
}
