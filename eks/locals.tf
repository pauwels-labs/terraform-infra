resource "random_id" "suffix" {
  count = 25

  byte_length = 4
}

locals {
  dns_account_role_arn    = "arn:aws:iam::${var.dns_account_id}:role/${var.dns_account_assume_role_name}"
  keys_account_role_arn    = "arn:aws:iam::${var.keys_account_id}:role/${var.keys_account_assume_role_name}"
  cluster_account_role_arn = "arn:aws:iam::${var.cluster_account_id}:role/${var.cluster_account_assume_role_name}"
  az_count                 = min(length(data.aws_availability_zones.available.names), var.az_count)
  subnet_count             = var.cluster_count * local.az_count
  nat_gateway_count        = var.ha_nat_gateways ? local.az_count : 1

  cluster_index                  = range(25)
  cluster_iam_role_name          = tolist([for i in local.cluster_index : "${local.cluster_names[i]}-cluster-${random_id.suffix[i].hex}"])
  cluster_encryption_policy_name = tolist([for i in local.cluster_index : "${local.cluster_names[i]}-cluster-ClusterEncryption-${random_id.suffix[i].hex}"])
  cluster_create                 = [for i in local.cluster_index : i + 1 <= var.cluster_count]
  cluster_names                  = [for i in local.cluster_index : "${var.cluster_name}-${i}"]

  clusters = slice([
    local.cluster_create[0] ? module.c0[0] : null,
    local.cluster_create[1] ? module.c1[0] : null,
    local.cluster_create[2] ? module.c2[0] : null,
    local.cluster_create[3] ? module.c3[0] : null,
    local.cluster_create[4] ? module.c4[0] : null,
    local.cluster_create[5] ? module.c5[0] : null,
    local.cluster_create[6] ? module.c6[0] : null,
    local.cluster_create[7] ? module.c7[0] : null,
    local.cluster_create[8] ? module.c8[0] : null,
    local.cluster_create[9] ? module.c9[0] : null,
    local.cluster_create[10] ? module.c10[0] : null,
    local.cluster_create[11] ? module.c11[0] : null,
    local.cluster_create[12] ? module.c12[0] : null,
    local.cluster_create[13] ? module.c13[0] : null,
    local.cluster_create[14] ? module.c14[0] : null,
    local.cluster_create[15] ? module.c15[0] : null,
    local.cluster_create[16] ? module.c16[0] : null,
    local.cluster_create[17] ? module.c17[0] : null,
    local.cluster_create[18] ? module.c18[0] : null,
    local.cluster_create[19] ? module.c19[0] : null,
    local.cluster_create[20] ? module.c20[0] : null,
    local.cluster_create[21] ? module.c21[0] : null,
    local.cluster_create[22] ? module.c22[0] : null,
    local.cluster_create[23] ? module.c23[0] : null,
    local.cluster_create[24] ? module.c24[0] : null
  ], 0, var.cluster_count)
}
