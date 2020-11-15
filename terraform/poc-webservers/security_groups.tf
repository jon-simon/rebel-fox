module "web_server_alb_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = data.aws_vpc.jibakurei.id

  ingress_cidr_blocks = ["192.168.1.0/24"]
}
