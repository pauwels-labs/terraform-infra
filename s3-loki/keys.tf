# General Loki key policy
data "aws_iam_policy_document" "loki_encryption_key_policy" {
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

# Loki ruler
resource "aws_kms_alias" "loki_ruler_encryption" {
  provider = aws.keys

  name          = "alias/s3-loki-ruler-encryption"
  target_key_id = aws_kms_key.loki_ruler_encryption.id
}

resource "aws_kms_key" "loki_ruler_encryption" {
  provider = aws.keys

  description              = "Used as the key to encrypt and decrypt the contents of the Loki Ruler S3 bucket"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.loki_encryption_key_policy.json

  tags = {
    Name        = "s3-loki-ruler-encryption"
    Description = "Used as the key to encrypt and decrypt the contents of the Loki Ruler S3 bucket"
  }
}

# Loki chunks
resource "aws_kms_alias" "loki_chunks_encryption" {
  provider = aws.keys

  name          = "alias/s3-loki-chunks-encryption"
  target_key_id = aws_kms_key.loki_chunks_encryption.id
}

resource "aws_kms_key" "loki_chunks_encryption" {
  provider = aws.keys

  description              = "Used as the key to encrypt and decrypt the contents of the Loki chunks S3 bucket"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.loki_encryption_key_policy.json

  tags = {
    Name        = "s3-loki-chunks-encryption"
    Description = "Used as the key to encrypt and decrypt the contents of the Loki chunks S3 bucket"
  }
}

# Loki admin
resource "aws_kms_alias" "loki_admin_encryption" {
  provider = aws.keys

  name          = "alias/s3-loki-admin-encryption"
  target_key_id = aws_kms_key.loki_admin_encryption.id
}

resource "aws_kms_key" "loki_admin_encryption" {
  provider = aws.keys

  description              = "Used as the key to encrypt and decrypt the contents of the Loki admin S3 bucket"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.loki_encryption_key_policy.json

  tags = {
    Name        = "s3-loki-admin-encryption"
    Description = "Used as the key to encrypt and decrypt the contents of the Loki admin S3 bucket"
  }
}
