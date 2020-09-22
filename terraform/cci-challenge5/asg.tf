module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = "cci_challenge5"

  # Launch configuration
  lc_name = "cci-challenge5-lc"

  image_id                    = data.aws_ami.base.id
  instance_type               = var.instance_type
  associate_public_ip_address = "false"
  iam_instance_profile        = aws_iam_instance_profile.cci_challenge5_instance_profile.id
  security_groups             = [module.cci_server_sg.this_security_group_id]
  key_name                    = "account_ec2_root_key"
  user_data = templatefile("${path.module}/userdata.tmpl", {
    tmpl_operator         = local.operator,
    tmpl_environment      = local.environment,
    tmpl_aws_account_name = local.aws_account_name
  })

  root_block_device = [
    {
      volume_size = "8"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "cci-challenge5-asg"
  vpc_zone_identifier       = ["${element(sort(tolist(data.aws_subnet_ids.private.ids)), count.index)}"]
  target_group_arns         = [join(",", module.cci_challenge5_nlb.target_group_arns)]
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

}