### Cluster envelope encryption key for secrets
resource "aws_kms_alias" "envelope_encryption" {
  provider = aws.keys
  count    = var.cluster_count

  name = "alias/k8s-envelope-encryption-${local.cluster_names[count.index]}"
  target_key_id = aws_kms_key.envelope_encryption[count.index].id
}

resource "aws_kms_key" "envelope_encryption" {
  provider = aws.keys
  count    = var.cluster_count

  description              = "Used as the key encryption key to decrypt data encryption keys that encrypt Kubernetes secrets"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.envelope_encryption_key_policy[count.index].json

  tags = {
    Name        = "k8s-envelope-encryption-${local.cluster_names[count.index]}"
    Description = "Used as the key encryption key to decrypt data encryption keys that encrypt Kubernetes secrets in the ${local.cluster_names[count.index]} cluster"
    Cluster     = local.cluster_names[count.index]
  }
}

data "aws_iam_policy_document" "envelope_encryption_key_policy" {
  provider = aws.keys
  count    = var.cluster_count

  statement {
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [local.keys_account_role_arn]
    }
  }
  statement {
    actions = [
      "kms:DescribeKey",
      "kms:CreateGrant"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [local.cluster_account_role_arn]
    }
  }
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ListGrants",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.cluster_account_id}:role/${local.cluster_iam_role_name[count.index]}"]
    }
  }
}

### EBS volume encryption key
resource "aws_kms_alias" "ebs_volume_encryption" {
  provider = aws.keys
  count    = var.cluster_count

  name = "alias/k8s-ebs-volume-encryption-${local.cluster_names[count.index]}"
  target_key_id = aws_kms_key.ebs_volume_encryption[count.index].id
}

resource "aws_kms_key" "ebs_volume_encryption" {
  provider = aws.keys
  count    = var.cluster_count

  description              = "Used as the key to encrypt and decrypt the contents of EBS volumes attached to cluster workloads in the ${local.cluster_names[count.index]} cluster"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.ebs_volume_encryption_key_policy[count.index].json

  tags = {
    Name        = "k8s-ebs-volume-encryption-${local.cluster_names[count.index]}"
    Description = "Used as the key to encrypt and decrypt the contents of EBS volumes attached to cluster workloads in the ${local.cluster_names[count.index]} cluster"
    Cluster     = local.cluster_names[count.index]
  }
}

data "aws_iam_policy_document" "ebs_volume_encryption_key_policy" {
  provider = aws.keys
  count    = var.cluster_count

  statement {
    actions = [
      "kms:*"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [local.keys_account_role_arn]
    }
  }
  statement {
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant",
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [aws_iam_role.ebs_csi_driver.arn]
    }
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = [
        "true"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "${local.clusters[count.index].oidc_provider}:aud"
      values   = [
        "sts.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "${local.clusters[count.index].oidc_provider}:sub"
      values   = [
        "system:serviceaccount:kube-system:ebs-csi-controller-sa"
      ]
    }
  }
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [aws_iam_role.ebs_csi_driver.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${local.clusters[count.index].oidc_provider}:aud"
      values   = [
        "sts.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "${local.clusters[count.index].oidc_provider}:sub"
      values   = [
        "system:serviceaccount:kube-system:ebs-csi-controller-sa"
      ]
    }
  }
}

### Vault AWS KMS auto-unseal key
resource "aws_kms_alias" "vault_auto_unseal" {
  provider = aws.keys
  count    = var.cluster_count

  name = "alias/k8s-vault-auto-unseal-${local.cluster_names[count.index]}"
  target_key_id = aws_kms_key.vault_auto_unseal[count.index].id
}

resource "aws_kms_key" "vault_auto_unseal" {
  provider = aws.keys
  count    = var.cluster_count

  description              = "Used as the key to unseal a vault instance in the ${local.cluster_names[count.index]} cluster"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.vault_auto_unseal_key_policy[count.index].json

  tags = {
    Name        = "k8s-vault-auto-unseal-${local.cluster_names[count.index]}"
    Description = "Used as the key to unseal a vault instance in the ${local.cluster_names[count.index]} cluster"
    Cluster     = local.cluster_names[count.index]
  }
}

data "aws_iam_policy_document" "vault_auto_unseal_key_policy" {
  provider = aws.keys
  count    = var.cluster_count

  statement {
    actions = [
      "kms:*"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [local.keys_account_role_arn]
    }
  }
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [aws_iam_role.vault.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${local.clusters[count.index].oidc_provider}:aud"
      values   = [
        "sts.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "${local.clusters[count.index].oidc_provider}:sub"
      values   = [
        "system:serviceaccount:i-vault:vault"
      ]
    }
  }
}
