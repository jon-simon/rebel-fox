//These should be set in Terraform Cloud
variable "aws_access_key" {}
variable "aws_account_name" {}
variable "aws_region" {}
variable "aws_secret_key" {}
variable "environment" {}
variable "name" {}
variable "operator" {}
variable "cluster_id" {}

variable "control_plane_count" {
  default = 1
}

variable "instance_type" {
  default = "t3.small"
}
