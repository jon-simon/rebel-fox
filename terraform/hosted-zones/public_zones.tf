## Private hosted zones are created as part of the VPC resources

resource "aws_route53_zone" "public" {
  name = "jibakurei.com"
}
