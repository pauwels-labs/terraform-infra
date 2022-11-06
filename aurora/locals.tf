locals {
  az_count                   = min(length(data.aws_availability_zones.available.names), var.az_count)
  databases_account_role_arn = "arn:aws:iam::${var.databases_account_id}:role/${var.databases_account_assume_role_name}"
  keys_account_role_arn      = "arn:aws:iam::${var.keys_account_id}:role/${var.keys_account_assume_role_name}"
}
