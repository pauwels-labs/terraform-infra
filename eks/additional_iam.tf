data "aws_iam_policy_document" "aws_lb_controller" {
  statement {
    actions   = [
      "iam:CreateServiceLinkedRole"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"

    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values   = [
        "elasticloadbalancing.amazonaws.com"
      ]
    }
  }

  statement {
    actions   = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeTags",
      "ec2:GetCoipPoolUsage",
      "ec2:DescribeCoipPools",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeTags"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"
  }

  statement {
    actions   = [
      "cognito-idp:DescribeUserPoolClient",
      "acm:ListCertificates",
      "acm:DescribeCertificate",
      "iam:ListServerCertificates",
      "iam:GetServerCertificate",
      "waf-regional:GetWebACL",
      "waf-regional:GetWebACLForResource",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL",
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "shield:GetSubscriptionState",
      "shield:DescribeProtection",
      "shield:CreateProtection",
      "shield:DeleteProtection"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"
  }

  statement {
    actions   = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"
  }

  statement {
    actions   = [
      "ec2:CreateSecurityGroup"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"
  }

  statement {
    actions   = [
      "ec2:CreateTags"
    ]
    resources = [
      "arn:aws:ec2:*:*:security-group/*"
    ]
    effect    = "Allow"

    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values   = [
        "CreateSecurityGroup"
      ]
    }
    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = [
        "false"
      ]
    }
  }

  statement {
    actions   = [
      "ec2:CreateTags",
      "ec2:DeleteTags"
    ]
    resources = [
      "arn:aws:ec2:*:*:security-group/*"
    ]
    effect    = "Allow"

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = [
        "true"
      ]
    }
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = [
        "false"
      ]
    }
  }

  statement {
    actions   = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = [
        "false"
      ]
    }
  }

  statement {
    actions   = [
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = [
        "false"
      ]
    }
  }

  statement {
    actions   = [
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:DeleteRule"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"
  }

  statement {
    actions   = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags"
    ]
    resources = [
      "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
    ]
    effect    = "Allow"

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = [
        "true"
      ]
    }
    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = [
        "false"
      ]
    }
  }

  statement {
    actions   = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags"
    ]
    resources = [
      "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
    ]
    effect    = "Allow"
  }

  statement {
    actions   = [
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:DeleteTargetGroup"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = [
        "false"
      ]
    }
  }

  statement {
    actions   = [
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets"
    ]
    resources = [
      "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
    ]
    effect    = "Allow"
  }

  statement {
    actions   = [
      "elasticloadbalancing:SetWebAcl",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:ModifyRule"
    ]
    resources = [
      "*"
    ]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "aws_lb_controller" {
  provider = aws.cluster

  name        = "AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "Permissions for the AWS Load Balancer Controller to administrate load balancers"

  policy = data.aws_iam_policy_document.aws_lb_controller.json
}

data "aws_iam_policy_document" "aws_lb_controller_trust_policy" {
  dynamic "statement" {
    for_each = local.clusters

    content {
      actions   = [
        "sts:AssumeRoleWithWebIdentity"
      ]
      effect    = "Allow"

      principals {
        type = "Federated"
        identifiers = [
          statement.value.oidc_provider_arn
        ]
      }

      condition {
        test     = "StringEquals"
        variable = "${statement.value.oidc_provider}:aud"
        values   = [
          "sts.amazonaws.com"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${statement.value.oidc_provider}:sub"
        values   = [
          "system:serviceaccount:kube-system:aws-load-balancer-controller"
        ]
      }
    }
  }
}

resource "aws_iam_role" "aws_lb_controller" {
  provider = aws.cluster

  name = "AmazonEKSLoadBalancerControllerRole-${var.cluster_name}"

  assume_role_policy = data.aws_iam_policy_document.aws_lb_controller_trust_policy.json

  tags = {
    Name        = "AmazonEKSLoadBalancerControllerRole-${var.cluster_name}"
    Description = "Role that the AWS Load Balancer in ${var.cluster_name} clusters assumes to manage load balancing"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "aws_lb_controller" {
  provider = aws.cluster

  role       = aws_iam_role.aws_lb_controller.name
  policy_arn = aws_iam_policy.aws_lb_controller.arn
}

data aws_iam_policy_document "pauwels_labs_ecr_policy" {
  statement {
    sid = "AllowRWAccessToPauwelsLabsECR"    
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
    resources = [
      var.ecr_arn
    ]
  }
  statement {
    sid = "AllowAuthTokenGeneration"    
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "pauwels_labs_ecr_policy" {
  provider = aws.cluster
  count    = var.use_ecr ? 1 : 0

  name = "AllowRWAccessToPauwelsLabsECR"
  path = "/"
  description = "Allows RW access to pauwels-labs ECR registry in the specified account"

  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_iam_role_policy_attachment" "grant_ecr_access_to_node_iam_roles" {
  provider = aws.cluster
  count    = var.use_ecr ? local.subnet_count : 0

  role       = values(local.clusters[floor(count.index / local.az_count)].eks_managed_node_groups)[count.index % local.az_count].iam_role_name
  policy_arn = aws_iam_policy.pauwels_labs_ecr_policy[0].arn
}

data "aws_iam_policy_document" "flux_ecr_trust_policy" {
  dynamic "statement" {
    for_each = local.clusters

    content {
      actions   = [
        "sts:AssumeRoleWithWebIdentity"
      ]
      effect    = "Allow"

      principals {
        type = "Federated"
        identifiers = [
          statement.value.oidc_provider_arn
        ]
      }

      condition {
        test     = "StringEquals"
        variable = "${statement.value.oidc_provider}:aud"
        values   = [
          "sts.amazonaws.com"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${statement.value.oidc_provider}:sub"
        values   = [
          "system:serviceaccount:flux-system:ecr-credentials-sync"
        ]
      }
    }
  }
}

resource "aws_iam_role" "flux_ecr" {
  provider = aws.cluster
  count    = var.use_ecr ? 1 : 0

  name = "${var.cluster_name}-flux-ecr"

  assume_role_policy = data.aws_iam_policy_document.flux_ecr_trust_policy.json

  tags = {
    Name        = "${var.cluster_name}-flux-ecr"
    Description = "Role that is used to provide Flux in the ${var.cluster_name} clusters an authenticated token for communication with images and Helm charts in an ECR registry"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_ecr_access_to_flux_ecr_role" {
  provider = aws.cluster
  count    = var.use_ecr ? 1 : 0

  role       = aws_iam_role.flux_ecr[0].name
  policy_arn = aws_iam_policy.pauwels_labs_ecr_policy[0].arn
}

data "aws_iam_policy_document" "external_dns" {
  count = 1
  statement {
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
    ]
    resources = ["arn:aws:route53:::hostedzone/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "external_dns" {
  provider = aws.dns
  count    = var.use_external_dns ? 1 : 0

  name        = "AllowK8sExternalDNS-${var.cluster_name}"
  description = "Allows an external-dns service in a ${var.cluster_name} k8s cluster to manage DNS records"
  policy      = data.aws_iam_policy_document.external_dns[count.index].json
}

data "aws_iam_policy_document" "external_dns_trust_policy" {
  dynamic "statement" {
    for_each = aws_iam_openid_connect_provider.dns_cluster_oidc_provider

    content {
      actions   = [
        "sts:AssumeRoleWithWebIdentity"
      ]
      effect    = "Allow"

      principals {
        type = "Federated"
        identifiers = [
          statement.value.arn
        ]
      }

      condition {
        test     = "StringEquals"
        variable = "${statement.value.url}:aud"
        values   = [
          "sts.amazonaws.com"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${statement.value.url}:sub"
        values   = [
          "system:serviceaccount:external-dns:external-dns"
        ]
      }
    }
  }
}

resource "aws_iam_role" "external_dns" {
  provider = aws.dns
  count    = var.use_external_dns ? 1 : 0

  name = "${var.cluster_name}-external-dns"

  assume_role_policy = data.aws_iam_policy_document.external_dns_trust_policy.json

  tags = {
    Name        = "${var.cluster_name}-external-dns"
    Description = "Role used to allow external-dns services in the ${var.cluster_name} clusters to manage DNS records"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_dns_access_to_external_dns_role" {
  provider = aws.dns
  count    = var.use_external_dns ? 1 : 0

  role       = aws_iam_role.external_dns[0].name
  policy_arn = aws_iam_policy.external_dns[0].arn
}

data "aws_iam_openid_connect_provider" "cluster_oidc_provider" {
  provider = aws.cluster
  count    = var.use_external_dns ? var.cluster_count : 0

  arn = local.clusters[count.index].oidc_provider_arn
}

resource "aws_iam_openid_connect_provider" "dns_cluster_oidc_provider" {
  provider = aws.dns
  count    = var.use_external_dns ? var.cluster_count : 0

  url             = "https://${data.aws_iam_openid_connect_provider.cluster_oidc_provider[count.index].url}"
  thumbprint_list = data.aws_iam_openid_connect_provider.cluster_oidc_provider[count.index].thumbprint_list
  client_id_list  = [
    "sts.amazonaws.com"
  ]
}
