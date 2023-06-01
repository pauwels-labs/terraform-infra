output "loki_ruler_key_arn" {
  value = aws_kms_key.loki_ruler_encryption.arn
}

output "loki_ruler_key_alias_arn" {
  value = aws_kms_alias.loki_ruler_encryption.arn
}

output "loki_ruler_bucket_arn" {
  value = aws_s3_bucket.loki_ruler.arn
}

output "loki_chunks_key_arn" {
  value = aws_kms_key.loki_chunks_encryption.arn
}

output "loki_chunks_key_alias_arn" {
  value = aws_kms_alias.loki_chunks_encryption.arn
}

output "loki_chunks_bucket_arn" {
  value = aws_s3_bucket.loki_chunks.arn
}

output "loki_admin_key_arn" {
  value = aws_kms_key.loki_admin_encryption.arn
}

output "loki_admin_key_alias_arn" {
  value = aws_kms_alias.loki_admin_encryption.arn
}

output "loki_admin_bucket_arn" {
  value = aws_s3_bucket.loki_admin.arn
}
