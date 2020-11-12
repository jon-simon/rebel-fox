module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "poc"
  cidr = "172.31.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets  = ["172.31.1.0/24", "172.31.2.0/24", "172.31.3.0/24"]
  private_subnets  = ["172.31.11.0/24", "172.31.12.0/24", "172.31.13.0/24"]

  # Single NAT Gateway
  enable_nat_gateway       = true
  single_nat_gateway       = true
  one_nat_gateway_per_az   = false

# enabling endpoints
  enable_dns_hostnames     = true
  enable_s3_endpoint       = true

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
