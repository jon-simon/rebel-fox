//These should be set in Terraform Cloud
variable "aws_access_key" {}
variable "aws_account_name" {}
variable "aws_region" {}
variable "aws_secret_key" {}
variable "environment" {}
variable "name" {}
variable "operator" {}
variable "cluster_id" {}

variable "kubernetes_version" {
  default = "1.19.2"
}
variable "pod_cidr" {
  default = "192.168.0.0/16"
}
variable "service_cidr" {
  default = "192.167.0.0/16"
}

variable "control_plane_count" {
  default = 1
}

variable "instance_type" {
  default = "t3.small"
}

