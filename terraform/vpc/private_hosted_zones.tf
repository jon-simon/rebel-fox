## Private hosted zones can be created within a VPC.

resource "aws_route53_zone" "private" {
  name = "private.jibakurei"
  vpc {
    vpc_id = module.vpc.vpc_id
  }
}
