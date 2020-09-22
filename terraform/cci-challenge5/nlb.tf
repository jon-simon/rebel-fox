module "cci_challenge5_nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "cci-challenge5-nlb"

  load_balancer_type = "network"

  vpc_id  = data.aws_vpc.jibakurei.id
  subnets = data.aws_subnet_ids.public.ids

  target_groups = [
    {
      name_prefix      = "cci-"
      backend_protocol = "TCP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "TLS"
      certificate_arn    = "arn:aws:acm:us-west-2:552172703831:certificate/b3da632b-f5bc-41e1-8a7f-1c8a33afbf6a"
      target_group_index = 0
    }
  ]

}