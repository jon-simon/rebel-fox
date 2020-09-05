//These should be set in Terraform Cloud
variable "aws_access_key" {}
variable "aws_account_name" {}
variable "aws_region" {}
variable "aws_secret_key" {}
variable "environment" {}
variable "name" {}
variable "operator" {}
variable "cluster_id" {}
// override this variable in terraform cloud
variable "worker_count" {
  description = "The number of K8s workers in the autoscaling group"
  default     = 1
}

variable "instance_type" {
  description = "The number of K8s workers in the autoscaling group"
  default     = "t3.small"
}