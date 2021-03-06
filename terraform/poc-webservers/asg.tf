// Creates an Auto-scaling group and Launch Configuration for the default-worker Server
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = "poc-webserver"

  # Launch configuration
  lc_name = "poc-webserver"

  image_id                    = data.aws_ami.base.id
  instance_type               = var.instance_type
  associate_public_ip_address = "false"
  iam_instance_profile        = aws_iam_instance_profile.webserver_instance_profile.id
  security_groups             = [module.webserver_ec2_sg.this_security_group_id]
  key_name                    = "account_ec2_root_key"
  user_data = templatefile("${path.module}/userdata.tmpl", {
    tmpl_name             = "poc-webserver",
    tmpl_operator         = local.operator,
    tmpl_environment      = local.environment,
    tmpl_aws_account_name = local.aws_account_name
    tmpl_k8s_cluster_id   = local.cluster_id
    }
  )
  root_block_device = [
    {
      volume_size = "20"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "poc-webserver"
  vpc_zone_identifier       = data.aws_subnet_ids.private.ids
  health_check_type         = "EC2"
  min_size                  = var.instance_count
  max_size                  = var.instance_count * 2
  desired_capacity          = var.instance_count
  wait_for_capacity_timeout = 0
  default_cooldown          = 0
  health_check_grace_period = 0
  target_group_arns = [join(",", module.alb.target_group_arns)]
  tags = [
    {
      key                 = "HostedZoneName"
      value               = trimsuffix(data.aws_route53_zone.root.name, ".")
      propagate_at_launch = true
    },
    {
      key                 = "Name"
      value               = "poc-webserver"
      propagate_at_launch = true
    },
  ]

  tags_as_map               = local.common_tags
}
