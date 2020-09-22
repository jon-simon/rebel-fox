// This will be used on the external NLB
resource "aws_route53_record" "control_plane" {
  zone_id = data.aws_route53_zone.root.zone_id
  name    = "challenge5.${data.aws_route53_zone.root.name}"
  type    = "CNAME"
  ttl     = "5"
  records = [module.cci_challenge5_nlb.this_lb_dns_name]
}
