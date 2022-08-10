resource "random_id" "suffix" {
  count = 25

  byte_length = 4
}

locals {
  keys_account_role_arn    = "arn:aws:iam::${var.keys_account_id}:role/${var.keys_account_assume_role_name}"
  cluster_account_role_arn = "arn:aws:iam::${var.cluster_account_id}:role/${var.cluster_account_assume_role_name}"
  az_count                 = min(length(data.aws_availability_zones.available.names), var.az_count)
  subnet_count             = var.cluster_count * local.az_count
  nat_gateway_count        = var.ha_nat_gateways ? local.az_count : 1

  cluster_index                  = range(25)
  cluster_iam_role_name          = tolist([for i in local.cluster_index : "${var.cluster_name}-${i}-cluster-${random_id.suffix[i].hex}"])
  cluster_encryption_policy_name = tolist([for i in local.cluster_index : "${var.cluster_name}-${i}-cluster-ClusterEncryption-${random_id.suffix[i].hex}"])
  cluster_create                 = [for i in local.cluster_index : i + 1 <= var.cluster_count]
}
