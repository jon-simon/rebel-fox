// This will be used on the external NLB
resource "aws_route53_record" "control_plane" {
  zone_id = data.aws_route53_zone.root.zone_id
  name    = "api.${local.cluster_id}.${data.aws_route53_zone.root.name}"
  type    = "CNAME"
  ttl     = "5"
  records = [module.control_plane_ext_api_lb.this_lb_dns_name]
}

// This will be used on the internal NLB
resource "aws_route53_record" "control_plane_internal" {
  zone_id = data.aws_route53_zone.root.zone_id
  name    = "api.${local.cluster_id}-internal.${data.aws_route53_zone.root.name}"
  type    = "CNAME"
  ttl     = "5"
  records = [module.control_plane_int_api_lb.this_lb_dns_name]
}
