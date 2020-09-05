// s3 bucket to store some objects off server. i.e. kube configs, pki
resource "aws_s3_bucket" "k8s_cluster" {
  bucket = join("-", [local.operator, local.cluster_id, var.aws_region])
  acl    = "private"

  tags = local.common_tags
}


// policy to allow only a control plane instance to put new objects to bucket and
// only administrator or devops role to read objects in the bucket.
data "aws_iam_policy_document" "k8s_cluster" {

  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:PutObject",
    ]
    resources = ["${aws_s3_bucket.k8s_cluster.arn}/*"]

    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.control_plane_role.arn
      ]
    }
  }

}

resource "aws_s3_bucket_policy" "k8s_cluster" {
  bucket = aws_s3_bucket.k8s_cluster.id
  policy = data.aws_iam_policy_document.k8s_cluster.json
}
