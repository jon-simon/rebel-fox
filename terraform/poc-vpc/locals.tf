// To avoid duplication all locals should be defined in this file
locals {
  operator     = var.operator
  name         = var.name
  service_name = "poc"
  environment  = var.environment

  common_tags = {
    Service     = local.service_name
    Owner       = local.operator
    Environment = local.environment
    Provisioner = "terraform"
  }
}
