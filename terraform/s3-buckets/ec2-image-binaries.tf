module "ec2_image_binaries_s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.operator}-image-binaries"
  acl    = "private"

  versioning = {
    enabled = true
  }

}
