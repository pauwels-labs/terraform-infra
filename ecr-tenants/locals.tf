locals {
  ecr_account_role_arn = "arn:aws:iam::${var.ecr_account_id}:role/${var.ecr_account_assume_role_name}"
  ecr_arn              = "arn:aws:ecr:eu-west-1:${var.ecr_account_id}:repository"
}
