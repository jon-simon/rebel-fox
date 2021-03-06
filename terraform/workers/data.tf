// To avoid duplication, all data sources should be defined in this file.

// returns the current account number
// Example usage: data.aws_ami.default.id
data "aws_caller_identity" "current" {}

// vpc id of the jibakurei vpc
// Example usage: data.aws_vpc.jibakurei.id
data "aws_vpc" "jibakurei" {
  filter {
    name   = "tag:Name"
    values = ["kubernetes"]
  }
}

data "aws_kms_alias" "session_manager" {
  name = "alias/session-manager"
}

// public subnet ids in jibakurei vpc
// Example usage: data.aws_subnet_ids.public.id
data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.jibakurei.id
  filter {
    name   = "tag:Name"
    values = ["kubernetes-pub-subnet"]
  }
}

data "aws_subnet" "public" {
  count = length(data.aws_subnet_ids.public.ids)
  id    = tolist(data.aws_subnet_ids.public.ids)[count.index]
}

// private subnet ids in jibakurei vpc
// Example usage: data.aws_subnet_ids.private.id
data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.jibakurei.id
  filter {
    name   = "tag:Name"
    values = ["kubernetes-priv-subnet"]
  }
}

data "aws_subnet" "private" {
  count = length(data.aws_subnet_ids.private.ids)
  id    = tolist(data.aws_subnet_ids.private.ids)[count.index]
}

// This will pull the latest available ami that starts with the defined name variable.
// Example usage: data.aws_ami.default.id
data "aws_ami" "base" {
  most_recent = true
  owners      = ["864776713922"]

  filter {
    name   = "name"
    values = ["${local.ami_name}-*"]
  }
}

// This will pull the latest available ami that starts with the defined name variable.
// Example usage: data.aws_security_group.vpc_default.id
data "aws_security_group" "vpc_default" {
  vpc_id = data.aws_vpc.jibakurei.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

// This will pull the latest available ami that starts with the defined name variable.
// Example usage: data.aws_route53_zone.jibakurei.id
data "aws_route53_zone" "root" {
  name = "jibakurei-${var.aws_account_name}.co."
}

// This will pull the latest available ami that starts with the defined name variable.
// Example usage: data.aws_route53_zone.jibakurei.id
data "aws_route53_zone" "private" {
  name         = "private.${local.aws_account_name}."
  private_zone = true
}

data "aws_availability_zones" "in_use" {
  filter {
    name   = "zone-name"
    values = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  }
}
