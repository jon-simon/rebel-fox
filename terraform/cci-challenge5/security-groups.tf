// security group for control-plane ec2 instances
module "cci_server_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "cci-challenge5-ec2-sg"
  description = "security group for cci challenge 5"
  vpc_id      = data.aws_vpc.jibakurei.id

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = [
    "all-all"
  ]

  ingress_with_self = [
    {
      rule = "all-all"
    },
  ]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = [
    "ssh-tcp",
    "http-80-tcp"
  ]
}
