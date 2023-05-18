# Mimir ruler
resource "aws_s3_bucket" "mimir_ruler" {
  provider = aws.artifacts

  bucket_prefix = "mimir-ruler-"

  tags = {
    Name = "mimir-ruler"
  }
}

resource "aws_s3_bucket_ownership_controls" "mimir_ruler" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.mimir_ruler.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "mimir_ruler" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.mimir_ruler.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "mimir_ruler_bucket_policy" {
  provider = aws.artifacts

  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.mimir_ruler.arn}",
      "${aws_s3_bucket.mimir_ruler.arn}/*"
    ]
    principals {
      type        = "AWS"      
      identifiers = [local.artifacts_account_role_arn]
    }
  }
  statement {
    effect  = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:GetObjectAttributes"
    ]
    resources = [
      "${aws_s3_bucket.mimir_ruler.arn}/*",
    ]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
  statement {
    effect  = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.mimir_ruler.arn,
    ]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
}

resource "aws_s3_bucket_policy" "mimir_ruler" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.mimir_ruler.id
  policy = data.aws_iam_policy_document.mimir_ruler_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mimir_ruler_encryption" {
  provider = aws.artifacts

  bucket                = aws_s3_bucket.mimir_ruler.bucket
  expected_bucket_owner = var.artifacts_account_id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_alias.mimir_ruler_encryption.arn
    }
  }
}

# Mimir blocks
resource "aws_s3_bucket" "mimir_blocks" {
  provider = aws.artifacts

  bucket_prefix = "mimir-blocks-"

  tags = {
    Name = "mimir-bocks"
  }
}

resource "aws_s3_bucket_ownership_controls" "mimir_blocks" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.mimir_blocks.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "mimir_blocks" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.mimir_blocks.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "mimir_blocks_bucket_policy" {
  provider = aws.artifacts

  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.mimir_blocks.arn}",
      "${aws_s3_bucket.mimir_blocks.arn}/*"
    ]
    principals {
      type        = "AWS"      
      identifiers = [local.artifacts_account_role_arn]
    }
  }
  statement {
    effect  = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:GetObjectAttributes"
    ]
    resources = [
      "${aws_s3_bucket.mimir_blocks.arn}/*"
    ]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
  statement {
    effect  = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.mimir_blocks.arn
    ]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
}

resource "aws_s3_bucket_policy" "mimir_blocks" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.mimir_blocks.id
  policy = data.aws_iam_policy_document.mimir_blocks_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mimir_blocks_encryption" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.mimir_blocks.bucket

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_alias.mimir_blocks_encryption.arn
    }
  }
}
