module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "image-builder"
  cidr = "192.168.1.0/24"

  azs             = ["us-west-2a"]
  public_subnets  = ["192.168.1.0/24"]

  public_subnet_tags = {
    Name = "overridden-name-public"
  }

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
}
