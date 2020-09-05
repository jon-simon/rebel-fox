// Creates a Network Load Balancer and Target Group for the control-plane Server
module "control_plane_ext_api_lb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "${local.service_name}-nlb-ext"

  load_balancer_type = "network"

  vpc_id  = data.aws_vpc.jibakurei.id
  subnets = data.aws_subnet_ids.public.ids

  target_groups = [
    {
      name                 = "${local.service_name}-ext"
      backend_protocol     = "TCP"
      backend_port         = 6443
      target_type          = "instance"
      deregistration_delay = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 6443
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "${local.service_name}-lb-ext"
    )
  )}"
}

// Creates a Network Load Balancer and Target Group for the control-plane Server
module "control_plane_int_api_lb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "${local.service_name}-nlb-int"

  load_balancer_type = "network"

  internal = true

  vpc_id  = data.aws_vpc.jibakurei.id
  subnets = data.aws_subnet_ids.public.ids

  target_groups = [
    {
      name                 = "${local.service_name}-int"
      backend_protocol     = "TCP"
      backend_port         = 6443
      target_type          = "instance"
      deregistration_delay = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 6443
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "${local.service_name}-lb-int"
    )
  )}"
}

