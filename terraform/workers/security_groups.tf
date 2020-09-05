
module "worker_ec2_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "${local.cluster_id}-worker-sg"
  description = "Security group for k8s worker nodes"
  vpc_id      = "${data.aws_vpc.jibakurei.id}"

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = [
    "all-all"
  ]

  ingress_with_self = [
    {
      rule = "all-all"
    },
  ]

  ingress_cidr_blocks = [data.aws_vpc.jibakurei.cidr_block]
  ingress_rules       = ["all-all"]
}
