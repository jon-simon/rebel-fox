// security group for control-plane ec2 instances
module "control_plane_ec2_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "${local.service_name}-ec2-sg"
  description = "Security group for control-plane with custom ports open within VPC, and to the white listed IPs"
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
  // ingress_cidr_blocks = [
  //   data.aws_vpc.jibakurei.cidr_block,
  //   "96.79.109.121/32"
  // ]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = [
    "ssh-tcp",
    "kubernetes-api-tcp"
  ]
  // ingressing the etcd client/peer ports
  ingress_with_cidr_blocks = [
    {
      from_port   = 2379
      to_port     = 2379
      protocol    = "tcp"
      description = "Etcd client"
      cidr_blocks = data.aws_vpc.jibakurei.cidr_block
    },
    {
      from_port   = 2380
      to_port     = 2380
      protocol    = "tcp"
      description = "Etcd server (peer)"
      cidr_blocks = data.aws_vpc.jibakurei.cidr_block
    },
  ]
}
