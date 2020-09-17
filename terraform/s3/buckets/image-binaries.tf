// s3 bucket for storing precompiled binaries that can be installed on instances
// or added to an image build

module "image_binary_s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.operator}-image-binaries"
  acl    = "private"

  versioning = {
    enabled = true
  }

}
