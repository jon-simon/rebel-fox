//These should be set in Terraform Cloud
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "name" {}
variable "operator" {}
variable "environment" {}
variable "aws_account_name" {}

variable "kubernetes_version" {
  default = "1.19.2"
}

variable "instance_type" {
  default = "t3.small"
}
