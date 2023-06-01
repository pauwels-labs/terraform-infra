# Loki ruler
resource "aws_s3_bucket" "loki_ruler" {
  provider = aws.artifacts

  bucket_prefix = "loki-ruler-"

  tags = {
    Name = "loki-ruler"
  }
}

resource "aws_s3_bucket_ownership_controls" "loki_ruler" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_ruler.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "loki_ruler" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_ruler.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "loki_ruler_bucket_policy" {
  provider = aws.artifacts

  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.loki_ruler.arn}",
      "${aws_s3_bucket.loki_ruler.arn}/*"
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
      "${aws_s3_bucket.loki_ruler.arn}/*",
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
      aws_s3_bucket.loki_ruler.arn,
    ]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
}

resource "aws_s3_bucket_policy" "loki_ruler" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_ruler.id
  policy = data.aws_iam_policy_document.loki_ruler_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "loki_ruler_encryption" {
  provider = aws.artifacts

  bucket                = aws_s3_bucket.loki_ruler.bucket
  expected_bucket_owner = var.artifacts_account_id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_alias.loki_ruler_encryption.arn
    }
  }
}

# Loki chunks
resource "aws_s3_bucket" "loki_chunks" {
  provider = aws.artifacts

  bucket_prefix = "loki-chunks-"

  tags = {
    Name = "loki-bocks"
  }
}

resource "aws_s3_bucket_ownership_controls" "loki_chunks" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_chunks.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "loki_chunks" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_chunks.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "loki_chunks_bucket_policy" {
  provider = aws.artifacts

  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.loki_chunks.arn}",
      "${aws_s3_bucket.loki_chunks.arn}/*"
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
      "${aws_s3_bucket.loki_chunks.arn}/*"
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
      aws_s3_bucket.loki_chunks.arn
    ]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
}

resource "aws_s3_bucket_policy" "loki_chunks" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_chunks.id
  policy = data.aws_iam_policy_document.loki_chunks_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "loki_chunks_encryption" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_chunks.bucket

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_alias.loki_chunks_encryption.arn
    }
  }
}

# Loki admin
resource "aws_s3_bucket" "loki_admin" {
  provider = aws.artifacts

  bucket_prefix = "loki-admin-"

  tags = {
    Name = "loki-bocks"
  }
}

resource "aws_s3_bucket_ownership_controls" "loki_admin" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_admin.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "loki_admin" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_admin.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "loki_admin_bucket_policy" {
  provider = aws.artifacts

  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.loki_admin.arn}",
      "${aws_s3_bucket.loki_admin.arn}/*"
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
      "${aws_s3_bucket.loki_admin.arn}/*"
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
      aws_s3_bucket.loki_admin.arn
    ]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
}

resource "aws_s3_bucket_policy" "loki_admin" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_admin.id
  policy = data.aws_iam_policy_document.loki_admin_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "loki_admin_encryption" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.loki_admin.bucket

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_alias.loki_admin_encryption.arn
    }
  }
}
