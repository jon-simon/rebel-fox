module "allow_ssm_vpc_enpoint" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "vpc-ssm-endpoint-allow-443"
  description = "Allowing traffice from within the VPC to the SSM VPC enpoints on port 443"
  vpc_id      = module.vpc.vpc_id

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = [
    "all-all"
  ]

  ingress_cidr_blocks      = ["192.168.1.0/24"]
  ingress_rules            = ["https-443-tcp"]
}

module "allow_apigw_vpc_enpoint" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "vpc-ssm-endpoint-allow-443"
  description = "Allowing traffice from within the VPC to API Gateway endpoint"
  vpc_id      = module.vpc.vpc_id

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = [
    "all-all"
  ]

  ingress_cidr_blocks      = ["192.168.1.0/24"]
  ingress_rules            = ["https-443-tcp"]
}

module "allow_lambda_vpc_enpoint" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "vpc-ssm-endpoint-allow-443"
  description = "Allowing traffice from within the VPC to Lambda endpoint"
  vpc_id      = module.vpc.vpc_id

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = [
    "all-all"
  ]

  ingress_cidr_blocks      = ["192.168.1.0/24"]
  ingress_rules            = ["https-443-tcp"]
}
