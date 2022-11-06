### RDS storage encryption key
resource "aws_kms_alias" "this" {
  provider = aws.keys

  name = "alias/aurora-pgsql-storage-${var.name}"
  target_key_id = aws_kms_key.this.id
}

resource "aws_kms_key" "this" {
  provider = aws.keys

  description              = "Used as the key to encrypt and decrypt the ${var.name} Aurora Serverless v2 PostgreSQL database cluster storage"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.storage_encryption_key.json

  tags = {
    Name        = "aurora-pgsql-storage-${var.name}"
    Description = "Used as the key to encrypt and decrypt the ${var.name} Aurora Serverless v2 PostgreSQL database cluster storage"
    Cluster     = var.name
  }
}

data "aws_iam_policy_document" "storage_encryption_key" {
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
      "kms:CancelKeyDeletion",
      "kms:Tag*"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [local.keys_account_role_arn]
    }
  }
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
      identifiers = [local.databases_account_role_arn]
    }
  }
}

### RDS master credentials encryption key
resource "aws_kms_alias" "master_credentials" {
  provider = aws.keys

  name = "alias/aurora-pgsql-master-credentials-${var.name}"
  target_key_id = aws_kms_key.master_credentials.id
}

resource "aws_kms_key" "master_credentials" {
  provider = aws.keys

  description              = "Used as the key to encrypt and decrypt the ${var.name} Aurora Serverless v2 PostgreSQL database master credentials in AWS Secrets Manager"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.master_credentials_encryption_key.json

  tags = {
    Name        = "aurora-pgsql-master-credentials-${var.name}"
    Description = "Used as the key to encrypt and decrypt the ${var.name} Aurora Serverless v2 PostgreSQL database master credentials in AWS Secrets Manager"
    Cluster     = var.name
  }
}

data "aws_iam_policy_document" "master_credentials_encryption_key" {
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
      "kms:CancelKeyDeletion",
      "kms:Tag*"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [local.keys_account_role_arn]
    }
  }
  statement {
    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"      
      identifiers = [local.databases_account_role_arn]
    }
  }
}
