// To avoid duplication all locals should be defined in this file
locals {
  operator     = "${var.operator}"
  name         = "${var.name}"
  service_name = "${local.name}-${local.environment}"
  environment  = "${var.environment}"
  cluster_id = var.cluster_id
  ClusterID = local.cluster_id

  common_tags = {
    Service     = local.service_name
    Owner       = local.operator
    Environment = local.environment
    Provisioner = "terraform"
  }
}
