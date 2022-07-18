locals {
  keys_account_role_arn    = "arn:aws:iam::${var.keys_account_id}:role/${var.keys_account_assume_role_name}"
  cluster_account_role_arn = "arn:aws:iam::${var.cluster_account_id}:role/${var.cluster_account_assume_role_name}"
  az_count                 = min(length(data.aws_availability_zones.available.names), var.az_count)
  subnet_count             = var.cluster_count * local.az_count
  nat_gateway_count        = var.ha_nat_gateways ? local.az_count : 1
}
