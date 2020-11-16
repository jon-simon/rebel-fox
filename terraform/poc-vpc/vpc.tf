module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "poc"
  cidr = "192.168.1.0/24"

  azs             = ["us-west-2a", "us-west-2b"]
  public_subnets  = ["192.168.1.0/26", "192.168.1.64/26"]
  private_subnets  = ["192.168.1.128/26", "192.168.1.192/26"]

  # Single NAT Gateway
  enable_nat_gateway       = true
  single_nat_gateway       = false
  one_nat_gateway_per_az   = true

# enabling endpoints
  enable_dns_hostnames     = true
  enable_s3_endpoint       = true
  enable_dynamodb_endpoint = false
  enable_lambda_endpoint = true
  enable_apigw_endpoint = true

  ## enabling SSM endpoints
  enable_ssm_endpoint = true
  ssm_endpoint_private_dns_enabled = true
  ssm_endpoint_security_group_ids = [module.allow_ssm_vpc_enpoint.this_security_group_id]

  ## enable ec2 messages endpoints
  enable_ec2messages_endpoint	= true
  ec2messages_endpoint_private_dns_enabled = true
  ec2messages_endpoint_security_group_ids = [module.allow_ssm_vpc_enpoint.this_security_group_id]

  tags = "${merge(local.common_tags,
    {
      "Name"   = local.service_name,
      "Module" = "vpc",
    }
  )}"

  public_subnet_tags = "${merge(local.common_tags,
    {
      "Name"   = "${local.service_name}-pub-subnet",
      "Module" = "vpc",
    }
  )}"

  private_subnet_tags = "${merge(local.common_tags,
    {
      "Name"   = "${local.service_name}-priv-subnet",
      "Module" = "vpc",
    }
  )}"
}
