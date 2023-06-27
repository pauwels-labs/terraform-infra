# General Tempo key policy
data "aws_iam_policy_document" "tempo_encryption_key_policy" {
  provider = aws.keys

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
    effect  = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey",
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
}

# Tempo traces
resource "aws_kms_alias" "tempo_traces_encryption" {
  provider = aws.keys

  name          = "alias/s3-tempo-traces-encryption"
  target_key_id = aws_kms_key.tempo_traces_encryption.id
}

resource "aws_kms_key" "tempo_traces_encryption" {
  provider = aws.keys

  description              = "Used as the key to encrypt and decrypt the contents of the Tempo traces S3 bucket"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.tempo_encryption_key_policy.json

  tags = {
    Name        = "s3-tempo-traces-encryption"
    Description = "Used as the key to encrypt and decrypt the contents of the Tempo traces S3 bucket"
  }
}

# Tempo admin
resource "aws_kms_alias" "tempo_admin_encryption" {
  provider = aws.keys

  name          = "alias/s3-tempo-admin-encryption"
  target_key_id = aws_kms_key.tempo_admin_encryption.id
}

resource "aws_kms_key" "tempo_admin_encryption" {
  provider = aws.keys

  description              = "Used as the key to encrypt and decrypt the contents of the Tempo admin S3 bucket"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.tempo_encryption_key_policy.json

  tags = {
    Name        = "s3-tempo-admin-encryption"
    Description = "Used as the key to encrypt and decrypt the contents of the Tempo admin S3 bucket"
  }
}
