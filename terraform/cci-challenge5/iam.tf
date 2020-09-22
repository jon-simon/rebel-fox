# data "aws_iam_policy_document" "assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# //TODO: Make clusterID a prefix instead of a suffix
# resource "aws_iam_role" "cci_challenge5_role" {
#   name               = "cci-challenge5-ec2-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
# }

# //TODO: Fine tune s3 permissions.  They've been added to allow ssm sesson manager logging.
# data "aws_iam_policy_document" "cci_challenge5_cw_permissions" {

#   statement {
#     effect = "Allow"
#     actions = [
#       "autoscaling:Describe*",
#       "cloudwatch:GetMetricStatistics",
#       "cloudwatch:ListMetrics",
#       "cloudwatch:PutMetricData",
#       "ec2:AttachVolume",
#       "ec2:AuthorizeSecurityGroupIngress",
#       "ec2:CreateRoute",
#       "ec2:CreateSecurityGroup",
#       "ec2:CreateTags",
#       "ec2:CreateVolume",
#       "ec2:DeleteRoute",
#       "ec2:DeleteSecurityGroup",
#       "ec2:DeleteVolume",
#       "ec2:Describe*",
#       "ec2:DetachVolume",
#       "ec2:ModifyInstanceAttribute",
#       "ec2:ModifyVolume",
#       "ec2:RevokeSecurityGroupIngress",
#       "ec2messages:AcknowledgeMessage",
#       "ec2messages:DeleteMessage",
#       "ec2messages:FailMessage",
#       "ec2messages:GetEndpoint",
#       "ec2messages:GetMessages",
#       "ec2messages:SendReply",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:BatchGetImage",
#       "ecr:Describe*",
#       "ecr:GetAuthorizationToken",
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:GetLifecyclePolicy",
#       "ecr:GetLifecyclePolicyPreview",
#       "ecr:GetRepositoryPolicy",
#       "ecr:List*",
#       "ecr:ListTagsForResource",
#       "elasticloadbalancing:AddTags",
#       "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
#       "elasticloadbalancing:AttachLoadBalancerToSubnets",
#       "elasticloadbalancing:ConfigureHealthCheck",
#       "elasticloadbalancing:CreateListener",
#       "elasticloadbalancing:CreateLoadBalancer",
#       "elasticloadbalancing:CreateLoadBalancerListeners",
#       "elasticloadbalancing:CreateLoadBalancerPolicy",
#       "elasticloadbalancing:CreateTargetGroup",
#       "elasticloadbalancing:DeleteListener",
#       "elasticloadbalancing:DeleteLoadBalancer",
#       "elasticloadbalancing:DeleteLoadBalancerListeners",
#       "elasticloadbalancing:DeleteTargetGroup",
#       "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
#       "elasticloadbalancing:DeregisterTargets",
#       "elasticloadbalancing:Describe*",
#       "elasticloadbalancing:DetachLoadBalancerFromSubnets",
#       "elasticloadbalancing:ModifyListener",
#       "elasticloadbalancing:ModifyLoadBalancerAttributes",
#       "elasticloadbalancing:ModifyTargetGroup",
#       "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
#       "elasticloadbalancing:RegisterTargets",
#       "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
#       "elasticloadbalancing:SetLoadBalancerPoliciesOfListener",
#       "iam:CreateServiceLinkedRole",
#       "kms:DescribeKey",
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:Describe*",
#       "logs:PutLogEvents",
#       "route53:ListHostedZones",
#       "route53:ListResourceRecordSets",
#       "s3:AbortMultipartUpload",
#       "s3:GetBucketLocation",
#       "s3:GetEncryptionConfiguration",
#       "s3:GetObject",
#       "s3:ListBucket",
#       "s3:ListBucketMultipartUploads",
#       "s3:ListMultipartUploadParts",
#       "s3:PutObject",
#       "ssm:DescribeAssociation",
#       "ssm:DescribeDocument",
#       "ssm:GetDeployablePatchSnapshotForInstance",
#       "ssm:GetDocument",
#       "ssm:GetManifest",
#       "ssm:ListAssociations",
#       "ssm:ListInstanceAssociations",
#       "ssm:PutComplianceItems",
#       "ssm:PutConfigurePackageResult",
#       "ssm:PutInventory",
#       "ssm:UpdateAssociationStatus",
#       "ssm:UpdateInstanceAssociationStatus",
#       "ssm:UpdateInstanceInformation",
#       "ssmmessages:CreateControlChannel",
#       "ssmmessages:CreateDataChannel",
#       "ssmmessages:OpenControlChannel",
#       "ssmmessages:OpenDataChannel"
#     ]
#     resources = ["*"]
#   }

#   statement {
#     effect = "Allow"
#     actions = [
#       "kms:GenerateDataKey",
#       "kms:Decrypt"
#     ]
#     resources = [data.aws_kms_alias.session_manager.target_key_arn]
#   }

#   statement {
#     effect = "Allow"
#     actions = [
#       "route53:ChangeResourceRecordSets",
#       "route53:GetHostedZone",
#     ]
#     resources = ["arn:aws:route53:::hostedzone/${data.aws_route53_zone.private.zone_id}"]
#   }

#   // closing bracket
# }

# resource "aws_iam_role_policy" "cci_challenge5_policy" {
#   name   = "cci-challenge5-policy"
#   policy = data.aws_iam_policy_document.cci_challenge5_cw_permissions.json
#   role   = aws_iam_role.cci_challenge5_role.id
# }

# resource "aws_iam_instance_profile" "cci_challenge5_instance_profile" {
#   name = aws_iam_role.cci_challenge5_role.name
#   path = "/"
#   role = aws_iam_role.cci_challenge5_role.name
# }
