output "tempo_traces_key_arn" {
  value = aws_kms_key.tempo_traces_encryption.arn
}

output "tempo_traces_key_alias_arn" {
  value = aws_kms_alias.tempo_traces_encryption.arn
}

output "tempo_traces_bucket_arn" {
  value = aws_s3_bucket.tempo_traces.arn
}

output "tempo_admin_key_arn" {
  value = aws_kms_key.tempo_admin_encryption.arn
}

output "tempo_admin_key_alias_arn" {
  value = aws_kms_alias.tempo_admin_encryption.arn
}

output "tempo_admin_bucket_arn" {
  value = aws_s3_bucket.tempo_admin.arn
}
