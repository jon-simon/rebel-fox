module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "kubernetes"
  cidr = "${var.cidr_block}"

  azs              = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  public_subnets = slice(local.subnets, 0, 3)
  private_subnets = slice(local.subnets, 3, 6)
  database_subnets = slice(local.subnets, 6, 9)

# Single NAT Gateway
  enable_nat_gateway       = true
  single_nat_gateway       = true
  one_nat_gateway_per_az   = false

# enabling endpoints
  enable_dns_hostnames     = true
  enable_s3_endpoint       = true
  enable_dynamodb_endpoint = true
  ## enabling SSM endpoints
  enable_ssm_endpoint = true
  ssm_endpoint_private_dns_enabled = true
  ssm_endpoint_security_group_ids = [module.allow_ssm_vpc_enpoint.this_security_group_id]
  ## enable ec2 messages endpoints
  enable_ec2messages_endpoint	= true
  ec2messages_endpoint_private_dns_enabled = true
  ec2messages_endpoint_security_group_ids = [module.allow_ssm_vpc_enpoint.this_security_group_id]

  // Adding tags to the VPC, Subnets, and Endpoints
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

  database_subnet_tags = "${merge(local.common_tags,
    {
      "Name"   = "${local.service_name}-db-subnet",
      "Module" = "vpc",
    }
  )}"

  vpc_endpoint_tags = "${merge(local.common_tags,
    {
      "Name"   = "${local.service_name}-vpc-endpoint",
      "Module" = "vpc",
    }
  )}"
}
