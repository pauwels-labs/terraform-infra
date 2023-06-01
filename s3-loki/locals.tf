locals {
  artifacts_account_role_arn = "arn:aws:iam::${var.artifacts_account_id}:role/${var.artifacts_account_assume_role_name}"
  keys_account_role_arn = "arn:aws:iam::${var.keys_account_id}:role/${var.keys_account_assume_role_name}"
}
