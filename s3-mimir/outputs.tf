output "mimir_ruler_key_arn" {
  value = aws_kms_key.mimir_ruler_encryption.arn
}

output "mimir_ruler_key_alias_arn" {
  value = aws_kms_alias.mimir_ruler_encryption.arn
}

output "mimir_ruler_bucket_arn" {
  value = aws_s3_bucket.mimir_ruler.arn
}

output "mimir_blocks_key_arn" {
  value = aws_kms_key.mimir_blocks_encryption.arn
}

output "mimir_blocks_key_alias_arn" {
  value = aws_kms_alias.mimir_blocks_encryption.arn
}

output "mimir_blocks_bucket_arn" {
  value = aws_s3_bucket.mimir_blocks.arn
}
