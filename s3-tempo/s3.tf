# Tempo traces
resource "aws_s3_bucket" "tempo_traces" {
  provider = aws.artifacts

  bucket_prefix = "tempo-traces-"

  tags = {
    Name = "tempo-traces"
  }
}

resource "aws_s3_bucket_ownership_controls" "tempo_traces" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.tempo_traces.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "tempo_traces" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.tempo_traces.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "tempo_traces_bucket_policy" {
  provider = aws.artifacts

  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.tempo_traces.arn}",
      "${aws_s3_bucket.tempo_traces.arn}/*"
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
      "${aws_s3_bucket.tempo_traces.arn}/*",
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
      aws_s3_bucket.tempo_traces.arn,
    ]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
}

resource "aws_s3_bucket_policy" "tempo_traces" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.tempo_traces.id
  policy = data.aws_iam_policy_document.tempo_traces_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tempo_traces_encryption" {
  provider = aws.artifacts

  bucket                = aws_s3_bucket.tempo_traces.bucket
  expected_bucket_owner = var.artifacts_account_id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_alias.tempo_traces_encryption.arn
    }
  }
}

# Tempo admin
resource "aws_s3_bucket" "tempo_admin" {
  provider = aws.artifacts

  bucket_prefix = "tempo-admin-"

  tags = {
    Name = "tempo-admin"
  }
}

resource "aws_s3_bucket_ownership_controls" "tempo_admin" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.tempo_admin.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "tempo_admin" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.tempo_admin.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "tempo_admin_bucket_policy" {
  provider = aws.artifacts

  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.tempo_admin.arn}",
      "${aws_s3_bucket.tempo_admin.arn}/*"
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
      "${aws_s3_bucket.tempo_admin.arn}/*"
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
      aws_s3_bucket.tempo_admin.arn
    ]
    principals {
      type        = "AWS"      
      identifiers = var.authorized_role_arns
    }
  }
}

resource "aws_s3_bucket_policy" "tempo_admin" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.tempo_admin.id
  policy = data.aws_iam_policy_document.tempo_admin_bucket_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tempo_admin_encryption" {
  provider = aws.artifacts

  bucket = aws_s3_bucket.tempo_admin.bucket

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_alias.tempo_admin_encryption.arn
    }
  }
}
