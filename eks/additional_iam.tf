# AWS Load Balancer Controller
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

# Flux ECR
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

data "aws_iam_policy_document" "infra_ecr_trust_policy" {
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
        test     = "StringLike"
        variable = "${statement.value.oidc_provider}:sub"
        values   = [
          "system:serviceaccount:i-*:ecr-credentials-sync",
          "system:serviceaccount:flux-system:ecr-credentials-sync"
        ]
      }
    }
  }
}

resource "aws_iam_role" "infra_ecr" {
  provider = aws.cluster
  count    = var.use_ecr ? 1 : 0

  name = "${var.cluster_name}-infra-ecr"

  assume_role_policy = data.aws_iam_policy_document.infra_ecr_trust_policy.json

  tags = {
    Name        = "${var.cluster_name}-infra-ecr"
    Description = "Role that is used to provide infrastructure workloads in the ${var.cluster_name} clusters an authenticated token for communication with images and Helm charts in an ECR registry"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_ecr_access_to_infra_ecr_role" {
  provider = aws.cluster
  count    = var.use_ecr ? 1 : 0

  role       = aws_iam_role.infra_ecr[0].name
  policy_arn = aws_iam_policy.pauwels_labs_ecr_policy[0].arn
}

# External DNS
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
  description = "Allows an external-dns service in a ${var.cluster_name} k8s clusters to manage DNS records"
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
          "system:serviceaccount:i-external-dns:external-dns"
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

# Certificate Manager
data "aws_iam_policy_document" "cert_manager" {
  count = 1

  statement {
    effect = "Allow"
    actions = [
      "route53:GetChange",
    ]
    resources = ["arn:aws:route53:::change/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]
    resources = ["arn:aws:route53:::hostedzone/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "route53:ListHostedZonesByName",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cert_manager" {
  provider = aws.dns
  count    = var.use_cert_manager ? 1 : 0

  name        = "AllowK8sCertManager-${var.cluster_name}"
  description = "Allows a cert-manager service in a ${var.cluster_name} k8s clusters to manage DNS records for DNS01 verification"
  policy      = data.aws_iam_policy_document.cert_manager[count.index].json
}

data "aws_iam_policy_document" "cert_manager_trust_policy" {
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
          "system:serviceaccount:i-cert-manager:cert-manager"
        ]
      }
    }
  }
}

resource "aws_iam_role" "cert_manager" {
  provider = aws.dns
  count    = var.use_cert_manager ? 1 : 0

  name = "${var.cluster_name}-cert-manager"

  assume_role_policy = data.aws_iam_policy_document.cert_manager_trust_policy.json

  tags = {
    Name        = "${var.cluster_name}-cert-manager"
    Description = "Role used to allow cert-manager services in the ${var.cluster_name} clusters to manage DNS records for DNS01 verification"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_dns_access_to_cert_manager_role" {
  provider = aws.dns
  count    = var.use_cert_manager ? 1 : 0

  role       = aws_iam_role.cert_manager[0].name
  policy_arn = aws_iam_policy.cert_manager[0].arn
}

# AWS EBS CSI controller
data "aws_iam_policy" "ebs_csi_driver" {
  provider = aws.cluster

  name = "AmazonEBSCSIDriverPolicy"
}

data "aws_iam_policy_document" "ebs_csi_driver_kms" {
  dynamic "statement" {
    for_each = aws_kms_alias.ebs_volume_encryption

    content {
      effect = "Allow"
      actions = [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ]
      resources = ["*"]
      condition {
        test     = "Bool"
        variable = "kms:GrantIsForAWSResource"
        values   = [
          "true"
        ]
      }
      condition {
        test     = "ForAnyValue:StringEquals"
        variable = "kms:ResourceAliases"
        values   = [
          "${statement.value.name}"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${local.clusters[statement.key].oidc_provider}:aud"
        values   = [
          "sts.amazonaws.com"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${local.clusters[statement.key].oidc_provider}:sub"
        values   = [
          "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        ]
      }
    }
  }
  
  dynamic "statement" {
    for_each = aws_kms_alias.ebs_volume_encryption

    content {
      effect = "Allow"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ]
      resources = ["*"]
      condition {
        test     = "ForAnyValue:StringEquals"
        variable = "kms:ResourceAliases"
        values   = [
          "${statement.value.name}"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${local.clusters[statement.key].oidc_provider}:aud"
        values   = [
          "sts.amazonaws.com"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${local.clusters[statement.key].oidc_provider}:sub"
        values   = [
          "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        ]
      }
    }
  }
}

resource "aws_iam_policy" "ebs_csi_driver_kms" {
  provider = aws.cluster
  
  name        = "AllowEBSCSIDriverKMSAccess-${var.cluster_name}"
  description = "Allows the EBS CSI driver in the ${var.cluster_name} k8s clusters to encrypt and decrypt EBS volumes with its specific KMS key"
  policy      = data.aws_iam_policy_document.ebs_csi_driver_kms.json
}

data "aws_iam_policy_document" "ebs_csi_driver_trust_policy" {
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
          "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        ]
      }
    }
  }
}

resource "aws_iam_role" "ebs_csi_driver" {
  provider = aws.cluster

  name = "${var.cluster_name}-ebs-csi-driver"

  assume_role_policy = data.aws_iam_policy_document.ebs_csi_driver_trust_policy.json

  tags = {
    Name        = "${var.cluster_name}-ebs-csi-driver"
    Description = "Role used to allow aws-ebs-csi-driver services in the ${var.cluster_name} clusters to manage EBS volumes for persistent volumes in the cluster"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_ebs_access_to_ebs_csi_driver_role" {
  provider = aws.cluster

  role       = aws_iam_role.ebs_csi_driver.name
  policy_arn = data.aws_iam_policy.ebs_csi_driver.arn
}

resource "aws_iam_role_policy_attachment" "grant_kms_access_to_ebs_csi_driver_role" {
  provider = aws.cluster

  role       = aws_iam_role.ebs_csi_driver.name
  policy_arn = aws_iam_policy.ebs_csi_driver_kms.arn
}

# Vault role
data "aws_iam_policy_document" "vault_auto_unseal" {
  dynamic "statement" {
    for_each = aws_kms_alias.vault_auto_unseal

    content {
      effect = "Allow"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:DescribeKey"
      ]
      resources = ["*"]
      condition {
        test     = "ForAnyValue:StringEquals"
        variable = "kms:ResourceAliases"
        values   = [
          "${statement.value.name}"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${local.clusters[statement.key].oidc_provider}:aud"
        values   = [
          "sts.amazonaws.com"
        ]
      }
      condition {
        test     = "StringEquals"
        variable = "${local.clusters[statement.key].oidc_provider}:sub"
        values   = [
          "system:serviceaccount:i-vault:vault"
        ]
      }
    }
  }  
}

resource "aws_iam_policy" "vault_auto_unseal" {
  provider = aws.cluster
  
  name        = "AllowVaultAutoUnsealAccess-${var.cluster_name}"
  description = "Allows the vault instance in the ${var.cluster_name} k8s clusters to unseal itself automatically using a key in KMS"
  policy      = data.aws_iam_policy_document.vault_auto_unseal.json
}

data "aws_iam_policy_document" "vault_trust_policy" {
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
          "system:serviceaccount:i-vault:vault"
        ]
      }
    }
  }
}

resource "aws_iam_role" "vault" {
  provider = aws.cluster

  name = "${var.cluster_name}-vault"

  assume_role_policy = data.aws_iam_policy_document.vault_trust_policy.json

  tags = {
    Name        = "${var.cluster_name}-vault"
    Description = "Role used to allow Vault in the ${var.cluster_name} clusters to automatically unseal itself using a key in JMS"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_auto_unseal_access_to_vault_role" {
  provider = aws.cluster

  role       = aws_iam_role.vault.name
  policy_arn = aws_iam_policy.vault_auto_unseal.arn
}

# Cluster autoscaler role
data "aws_iam_policy_document" "cluster_autoscaler" {
  statement {
    effect    = "Allow"
    actions   = [
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeAutoScalingGroups",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeInstanceTypes",
      "autoscaling:DescribeTags",
      "autoscaling:DescribeLaunchConfigurations"
    ]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = local.clusters

    content {
      effect    = "Allow"
      actions   = [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup"
      ]
      resources = ["*"]
      condition {
        test     = "StringEquals"
        variable = "aws:ResourceTag/k8s.io/cluster-autoscaler/${statement.value.cluster_id}"
        values   = [
          "owned"
        ]
      }
    }
  }  
}

resource "aws_iam_policy" "cluster_autoscaler" {
  provider = aws.cluster
  
  name        = "AllowClusterAutoscaling-${var.cluster_name}"
  description = "Allows the cluster autoscaler instance in the ${var.cluster_name} k8s clusters to manage auto scaling groups"
  policy      = data.aws_iam_policy_document.cluster_autoscaler.json
}

data "aws_iam_policy_document" "cluster_autoscaler_trust_policy" {
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
          "system:serviceaccount:kube-system:cluster-autoscaler"
        ]
      }
    }
  }
}

resource "aws_iam_role" "cluster_autoscaler" {
  provider = aws.cluster

  name = "${var.cluster_name}-cluster-autoscaler"

  assume_role_policy = data.aws_iam_policy_document.cluster_autoscaler_trust_policy.json

  tags = {
    Name        = "${var.cluster_name}-cluster-autoscaler"
    Description = "Role used to allow cluster autoscaler in the ${var.cluster_name} clusters to manage auto-scaling groups"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_autoscaling_access_to_cluster_autoscaler_role" {
  provider = aws.cluster

  role       = aws_iam_role.cluster_autoscaler.name
  policy_arn = aws_iam_policy.cluster_autoscaler.arn
}

# Mimir role
data "aws_iam_policy_document" "mimir" {
  count = var.use_mimir ? 1 : 0

  statement {
    effect    = "Allow"
    actions   = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:ResourceAliases"
      values   = [
        var.mimir_ruler_key_alias_name,
        var.mimir_blocks_key_alias_name
      ]
    }
  }
  statement {
    effect    = "Allow"
    actions   = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:GetObjectAttributes"
    ]
    resources = [
      "${var.mimir_ruler_bucket_arn}/*",
      "${var.mimir_blocks_bucket_arn}/*"
    ]
  }
  statement {
    effect    = "Allow"
    actions   = [
      "s3:ListBucket"
    ]
    resources = [
      "${var.mimir_ruler_bucket_arn}",
      "${var.mimir_blocks_bucket_arn}"
    ]
  }
}

resource "aws_iam_policy" "mimir" {
  provider = aws.cluster
  count = var.use_mimir ? 1 : 0
  
  name        = "AllowMimir-${var.cluster_name}"
  description = "Allows the various Mimir services in the ${var.cluster_name} k8s clusters to store objects in S3 buckets"
  policy      = data.aws_iam_policy_document.mimir[0].json
}

data "aws_iam_policy_document" "mimir_trust_policy" {
  count = var.use_mimir ? 1 : 0

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
          "system:serviceaccount:i-grafana-mimir:grafana-mimir"
        ]
      }
    }
  }
}

resource "aws_iam_role" "mimir" {
  provider = aws.cluster
  count = var.use_mimir ? 1 : 0

  name = "${var.cluster_name}-mimir"

  assume_role_policy = data.aws_iam_policy_document.mimir_trust_policy[0].json

  tags = {
    Name        = "${var.cluster_name}-mimir"
    Description = "Role used to allow Mimir services in the ${var.cluster_name} clusters to store objects in S3"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_s3_access_to_mimir_role" {
  provider = aws.cluster
  count = var.use_mimir ? 1 : 0

  role       = aws_iam_role.mimir[0].name
  policy_arn = aws_iam_policy.mimir[0].arn
}

# Loki role
data "aws_iam_policy_document" "loki" {
  count = var.use_loki ? 1 : 0

  statement {
    effect    = "Allow"
    actions   = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:ResourceAliases"
      values   = [
        var.loki_ruler_key_alias_name,
        var.loki_chunks_key_alias_name,
        var.loki_admin_key_alias_name
      ]
    }
  }
  statement {
    effect    = "Allow"
    actions   = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:GetObjectAttributes"
    ]
    resources = [
      "${var.loki_ruler_bucket_arn}/*",
      "${var.loki_chunks_bucket_arn}/*",
      "${var.loki_admin_bucket_arn}/*"
    ]
  }
  statement {
    effect    = "Allow"
    actions   = [
      "s3:ListBucket"
    ]
    resources = [
      "${var.loki_ruler_bucket_arn}",
      "${var.loki_chunks_bucket_arn}",
      "${var.loki_admin_bucket_arn}"
    ]
  }
}

resource "aws_iam_policy" "loki" {
  provider = aws.cluster
  count = var.use_loki ? 1 : 0
  
  name        = "AllowLoki-${var.cluster_name}"
  description = "Allows the various Loki services in the ${var.cluster_name} k8s clusters to store objects in S3 buckets"
  policy      = data.aws_iam_policy_document.loki[0].json
}

data "aws_iam_policy_document" "loki_trust_policy" {
  count = var.use_loki ? 1 : 0

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
          "system:serviceaccount:i-grafana-loki:grafana-loki"
        ]
      }
    }
  }
}

resource "aws_iam_role" "loki" {
  provider = aws.cluster
  count = var.use_loki ? 1 : 0

  name = "${var.cluster_name}-loki"

  assume_role_policy = data.aws_iam_policy_document.loki_trust_policy[0].json

  tags = {
    Name        = "${var.cluster_name}-loki"
    Description = "Role used to allow Loki services in the ${var.cluster_name} clusters to store objects in S3"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_s3_access_to_loki_role" {
  provider = aws.cluster
  count = var.use_loki ? 1 : 0

  role       = aws_iam_role.loki[0].name
  policy_arn = aws_iam_policy.loki[0].arn
}

# Tempo role
data "aws_iam_policy_document" "tempo" {
  count = var.use_tempo ? 1 : 0

  statement {
    effect    = "Allow"
    actions   = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:ResourceAliases"
      values   = [
        var.tempo_traces_key_alias_name,
        var.tempo_admin_key_alias_name
      ]
    }
  }
  statement {
    effect    = "Allow"
    actions   = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:GetObjectAttributes"
    ]
    resources = [
      "${var.tempo_traces_bucket_arn}/*",
      "${var.tempo_admin_bucket_arn}/*"
    ]
  }
  statement {
    effect    = "Allow"
    actions   = [
      "s3:ListBucket"
    ]
    resources = [
      "${var.tempo_traces_bucket_arn}",
      "${var.tempo_admin_bucket_arn}"
    ]
  }
}

resource "aws_iam_policy" "tempo" {
  provider = aws.cluster
  count = var.use_tempo ? 1 : 0
  
  name        = "AllowTempo-${var.cluster_name}"
  description = "Allows the various Tempo services in the ${var.cluster_name} k8s clusters to store objects in S3 buckets"
  policy      = data.aws_iam_policy_document.tempo[0].json
}

data "aws_iam_policy_document" "tempo_trust_policy" {
  count = var.use_tempo ? 1 : 0

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
          "system:serviceaccount:i-grafana-tempo:grafana-tempo"
        ]
      }
    }
  }
}

resource "aws_iam_role" "tempo" {
  provider = aws.cluster
  count = var.use_tempo ? 1 : 0

  name = "${var.cluster_name}-tempo"

  assume_role_policy = data.aws_iam_policy_document.tempo_trust_policy[0].json

  tags = {
    Name        = "${var.cluster_name}-tempo"
    Description = "Role used to allow Tempo services in the ${var.cluster_name} clusters to store objects in S3"
    Cluster     = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "grant_s3_access_to_tempo_role" {
  provider = aws.cluster
  count = var.use_tempo ? 1 : 0

  role       = aws_iam_role.tempo[0].name
  policy_arn = aws_iam_policy.tempo[0].arn
}
