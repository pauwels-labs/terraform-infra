# General Mimir key policy
data "aws_iam_policy_document" "mimir_encryption_key_policy" {
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

# Mimir ruler
resource "aws_kms_alias" "mimir_ruler_encryption" {
  provider = aws.keys

  name          = "alias/s3-mimir-ruler-encryption"
  target_key_id = aws_kms_key.mimir_ruler_encryption.id
}

resource "aws_kms_key" "mimir_ruler_encryption" {
  provider = aws.keys

  description              = "Used as the key to encrypt and decrypt the contents of the Mimir Ruler S3 bucket"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.mimir_encryption_key_policy.json

  tags = {
    Name        = "s3-mimir-ruler-encryption"
    Description = "Used as the key to encrypt and decrypt the contents of the Mimir Ruler S3 bucket"
  }
}

# Mimir blocks
resource "aws_kms_alias" "mimir_blocks_encryption" {
  provider = aws.keys

  name          = "alias/s3-mimir-blocks-encryption"
  target_key_id = aws_kms_key.mimir_blocks_encryption.id
}

resource "aws_kms_key" "mimir_blocks_encryption" {
  provider = aws.keys

  description              = "Used as the key to encrypt and decrypt the contents of the Mimir blocks S3 bucket"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.mimir_encryption_key_policy.json

  tags = {
    Name        = "s3-mimir-blocks-encryption"
    Description = "Used as the key to encrypt and decrypt the contents of the Mimir blocks S3 bucket"
  }
}
