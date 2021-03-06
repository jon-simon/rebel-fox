module "webserver_alb_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "webserver"
  description = "Security group for webserver with HTTP ports open within VPC"
  vpc_id      = data.aws_vpc.jibakurei.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}


module "webserver_ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "webserver"
  description = "Security group for EC2 to allow HTTP from ALB"
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
    "https-443-tcp"
    ]

computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.webserver_alb_sg.this_security_group_id
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}
