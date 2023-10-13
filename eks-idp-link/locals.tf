locals {
  cluster_account_role_arn   = "arn:aws:iam::${var.cluster_account_id}:role/${var.cluster_account_assume_role_name}"
  idp_url                    = trim(var.idp_url, "/")
}
