resource "aws_kms_alias" "envelope_encryption" {
  provider = aws.keys
  count    = var.cluster_count

  name = "alias/k8s-envelope-encryption-${var.cluster_name}-${count.index}"
  target_key_id = aws_kms_key.envelope_encryption[count.index].id
}

resource "aws_kms_key" "envelope_encryption" {
  provider = aws.keys
  count    = var.cluster_count

  description              = "Used as the key encryption key to decrypt data encryption keys that encrypt Kubernetes secrets"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.envelope_encryption_key_policy.json
}

data "aws_iam_policy_document" "envelope_encryption_key_policy" {
  provider = aws.keys

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
}
