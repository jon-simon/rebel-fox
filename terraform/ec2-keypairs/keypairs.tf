module "root_key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = "account_ec2_root_key"
  public_key = var.ec2_root_public_key
}
