# module "cci_challenge5_nlb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "~> 5.0"

#   name = "cci-challenge5-nlb"

#   load_balancer_type = "network"

#   vpc_id  = data.aws_vpc.jibakurei.id
#   subnets = data.aws_subnet_ids.public.ids

#   target_groups = [
#     {
#       name_prefix      = "cci-"
#       backend_protocol = "TCP"
#       backend_port     = 80
#       target_type      = "instance"
#     }
#   ]

#   https_listeners = [
#     {
#       port               = 443
#       protocol           = "TLS"
#       certificate_arn    = module.nlb_cert.this_acm_certificate_arn
#       target_group_index = 0
#     }
#   ]

# }