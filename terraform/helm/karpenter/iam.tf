#resource "aws_iam_instance_profile" "karpenter" {
#  name = "karpenter-controller"
#  role = aws_iam_role.karpenter_profile_instance_role.name
#}
#
#resource "aws_iam_policy" "instance_profile_policy" {
#  name        = "instance_profile-karpenter-policy"
#  description = "instance profile for karpenter policy"
#
#  policy = jsonencode({
#    "Version" : "2012-10-17",
#    "Statement" : [
#      {
#        "Effect" : "Allow",
#        "Action" : [
#          "ec2:DescribeInstances",
#          "ec2:DescribeInstanceTypes",
#          "ec2:DescribeRouteTables",
#          "ec2:DescribeSecurityGroups",
#          "ec2:DescribeSubnets",
#          "ec2:DescribeVolumes",
#          "ec2:DescribeVolumesModifications",
#          "ec2:DescribeVpcs",
#          "eks:DescribeCluster"
#        ],
#        "Resource" : "*"
#      },
#      {
#        "Effect" : "Allow",
#        "Action" : [
#          "ec2:AssignPrivateIpAddresses",
#          "ec2:AttachNetworkInterface",
#          "ec2:CreateNetworkInterface",
#          "ec2:DeleteNetworkInterface",
#          "ec2:DescribeInstances",
#          "ec2:DescribeTags",
#          "ec2:DescribeNetworkInterfaces",
#          "ec2:DescribeInstanceTypes",
#          "ec2:DetachNetworkInterface",
#          "ec2:ModifyNetworkInterfaceAttribute",
#          "ec2:UnassignPrivateIpAddresses"
#        ],
#        "Resource" : "*"
#      },
#      {
#        "Effect" : "Allow",
#        "Action" : [
#          "ec2:CreateTags"
#        ],
#        "Resource" : [
#          "arn:aws:ec2:*:*:network-interface/*"
#        ]
#      },
#      {
#        "Effect" : "Allow",
#        "Action" : [
#          "ecr:GetAuthorizationToken",
#          "ecr:BatchCheckLayerAvailability",
#          "ecr:GetDownloadUrlForLayer",
#          "ecr:GetRepositoryPolicy",
#          "ecr:DescribeRepositories",
#          "ecr:ListImages",
#          "ecr:DescribeImages",
#          "ecr:BatchGetImage",
#          "ecr:GetLifecyclePolicy",
#          "ecr:GetLifecyclePolicyPreview",
#          "ecr:ListTagsForResource",
#          "ecr:DescribeImageScanFindings"
#        ],
#        "Resource" : "*"
#      },
#      {
#        "Effect" : "Allow",
#        "Action" : [
#          "ssm:DescribeAssociation",
#          "ssm:GetDeployablePatchSnapshotForInstance",
#          "ssm:GetDocument",
#          "ssm:DescribeDocument",
#          "ssm:GetManifest",
#          "ssm:GetParameter",
#          "ssm:GetParameters",
#          "ssm:ListAssociations",
#          "ssm:ListInstanceAssociations",
#          "ssm:PutInventory",
#          "ssm:PutComplianceItems",
#          "ssm:PutConfigurePackageResult",
#          "ssm:UpdateAssociationStatus",
#          "ssm:UpdateInstanceAssociationStatus",
#          "ssm:UpdateInstanceInformation"
#        ],
#        "Resource" : "*"
#      },
#      {
#        "Effect" : "Allow",
#        "Action" : [
#          "ssmmessages:CreateControlChannel",
#          "ssmmessages:CreateDataChannel",
#          "ssmmessages:OpenControlChannel",
#          "ssmmessages:OpenDataChannel"
#        ],
#        "Resource" : "*"
#      },
#      {
#        "Effect" : "Allow",
#        "Action" : [
#          "ec2messages:AcknowledgeMessage",
#          "ec2messages:DeleteMessage",
#          "ec2messages:FailMessage",
#          "ec2messages:GetEndpoint",
#          "ec2messages:GetMessages",
#          "ec2messages:SendReply"
#        ],
#        "Resource" : "*"
#      }
#    ]
#  })
#}
#
#resource "aws_iam_role" "karpenter_profile_instance_role" {
#  name = format("karpenter-profile-instance")
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Action = "sts:AssumeRole"
#        Effect = "Allow"
#        Sid    = ""
#        Principal = {
#          "Service" : "ec2.amazonaws.com"
#        },
#      }
#    ]
#  })
#}
#
#
#resource "aws_iam_role_policy_attachment" "instance-profile-attach" {
#  role       = aws_iam_role.karpenter_profile_instance_role.name
#  policy_arn = aws_iam_policy.instance_profile_policy.arn
#}
#
#resource "aws_iam_policy" "karpenter_controller" {
#  name        = "karpenter-policy"
#  description = "karpenter-controller service account  policy"
#
#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Action = [
#          "ec2:CreateLaunchTemplate",
#          "ec2:CreateFleet",
#          "ec2:RunInstances",
#          "ec2:CreateTags",
#          "iam:PassRole",
#          "ec2:TerminateInstances",
#          "ec2:DescribeLaunchTemplates",
#          "ec2:DeleteLaunchTemplate",
#          "ec2:DescribeInstances",
#          "ec2:DescribeSecurityGroups",
#          "ec2:DescribeSubnets",
#          "ec2:DescribeInstanceTypes",
#          "ec2:DescribeInstanceTypeOfferings",
#          "ec2:DescribeAvailabilityZones",
#          "ssm:GetParameter",
#          "pricing:GetProducts"
#        ]
#        Effect   = "Allow"
#        Resource = "*"
#      },
#    ]
#  })
#}
#
#data "aws_ssm_parameter" "eks_oidc_arn" {
#  provider = aws.parameters
#  name     = "/eks/oidc/provider/arn"
#}
#
#resource "aws_iam_role" "karpenter_role" {
#  name = "karpenter-role"
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Action = "sts:AssumeRoleWithWebIdentity"
#        Effect = "Allow"
#        Principal = {
#          Federated = data.aws_ssm_parameter.eks_oidc_arn.value
#        }
#      },
#    ]
#  })
#}
#
#
#resource "aws_iam_role_policy_attachment" "karpenter-attach" {
#  role       = aws_iam_role.karpenter_role.name
#  policy_arn = aws_iam_policy.karpenter_controller.arn
#}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.aws_eks_cluster.eks_cluster.certificate_authority[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "karpenter_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:karpenter:karpenter"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "karpenter_controller" {
  assume_role_policy = data.aws_iam_policy_document.karpenter_controller_assume_role_policy.json
  name               = "karpenter-controller"
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_attach" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = aws_iam_policy.karpenter_controller.arn
}

resource "aws_iam_instance_profile" "karpenter" {
  name = "KarpenterNodeInstanceProfile"
  role = data.aws_ssm_parameter.eks_nodegroup_role_name.value
}

resource "aws_iam_policy" "karpenter_controller" {
  name        = "karpenter-controller-policy"
  description = "karpenter-controller service account  policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateFleet",
          "ec2:CreateLaunchTemplate",
          "ec2:CreateTags",
          "ec2:DeleteLaunchTemplate",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeInstances",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "iam:PassRole",
          "pricing:GetProducts",
          "ssm:GetParameter",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}