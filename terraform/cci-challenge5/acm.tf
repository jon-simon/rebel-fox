module "nlb_cert" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"

  domain_name = "challenge5.${data.aws_route53_zone.root.name}"
  zone_id     = data.aws_route53_zone.root.zone_id


  tags = {
    Name = "challenge5.${data.aws_route53_zone.root.name}"
  }
}
