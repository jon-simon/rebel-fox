// Creating the control plane singletons
module "control_plane_asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  count = var.control_plane_count

  name = "${local.cluster_id}-control-plane-${format("%02d", count.index + 1)}"

  # Launch configuration
  lc_name = "${local.cluster_id}-control-plane-${format("%02d", count.index + 1)}"

  image_id                    = data.aws_ami.base.id
  instance_type               = var.instance_type
  associate_public_ip_address = "false"
  iam_instance_profile        = aws_iam_instance_profile.control_plane_instance_profile.id
  security_groups             = [module.control_plane_ec2_sg.this_security_group_id]
  key_name                    = "account_ec2_root_key"
  user_data = templatefile("${path.module}/userdata.tmpl", {
    tmpl_name               = "${local.cluster_id}-control-plane-${format("%02d", count.index + 1)}",
    tmpl_operator           = local.operator,
    tmpl_environment        = local.environment,
    tmpl_aws_account_name   = local.aws_account_name
    tmpl_k8s_cluster_id     = local.cluster_id
    tmpl_member_count       = format("%02d", count.index + 1)
    tmpl_external_api       = aws_route53_record.control_plane.name
    tmpl_internal_api       = aws_route53_record.control_plane_internal.name
    tmpl_kubernetes_version = var.kubernetes_version
    tmpl_pod_cidr           = var.pod_cidr
    tmpl_service_cidr       = var.service_cidr
    tmpl_member             = format("%02d", count.index + 1)
    }
  )
  root_block_device = [
    {
      volume_size = "20"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name            = "${local.service_name}"
  vpc_zone_identifier = ["${element(sort(tolist(data.aws_subnet_ids.private.ids)), count.index)}"]
  target_group_arns = [
    join(",", module.control_plane_ext_api_lb.target_group_arns),
    join(",", module.control_plane_int_api_lb.target_group_arns),
  ]
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  default_cooldown          = 0
  health_check_grace_period = 0

  tags = [
    {
      key                 = "EtcdMember"
      value               = "etcd-${format("%02d", count.index + 1)}"
      propagate_at_launch = true
    },
    {
      key                 = "HostedZoneName"
      value               = trimsuffix(data.aws_route53_zone.root.name, ".")
      propagate_at_launch = true
    },
  ]
  tags_as_map = local.common_tags
}

// Creating the Persistent etcd data volumes
resource "aws_ebs_volume" "etcd_data" {
  count             = var.control_plane_count
  availability_zone = element(tolist(module.control_plane_asg[count.index].this_autoscaling_group_availability_zones), 0)
  size              = 10

  tags = {
    Name = "${local.cluster_id}-etcd-${format("%02d", count.index + 1)}-data"

  }
}
