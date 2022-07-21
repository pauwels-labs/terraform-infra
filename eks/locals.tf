locals {
  keys_account_role_arn    = "arn:aws:iam::${var.keys_account_id}:role/${var.keys_account_assume_role_name}"
  cluster_account_role_arn = "arn:aws:iam::${var.cluster_account_id}:role/${var.cluster_account_assume_role_name}"
  az_count                 = min(length(data.aws_availability_zones.available.names), var.az_count)
  subnet_count             = var.cluster_count * local.az_count
  nat_gateway_count        = var.ha_nat_gateways ? local.az_count : 1

  c0  = 0
  c1  = 1
  c2  = 2
  c3  = 3
  c4  = 4
  c5  = 5
  c6  = 6
  c7  = 7
  c8  = 8
  c9  = 9
  c10 = 10
  c11 = 11
  c12 = 12
  c13 = 13
  c14 = 14
  c15 = 15
  c16 = 16
  c17 = 17
  c18 = 18
  c19 = 19
  c20 = 20
  c21 = 21
  c22 = 22
  c23 = 23
  c24 = 24

  c0_create  = local.c0 + 1 <= var.cluster_count
  c1_create  = local.c1 + 1 <= var.cluster_count
  c2_create  = local.c2 + 1 <= var.cluster_count
  c3_create  = local.c3 + 1 <= var.cluster_count
  c4_create  = local.c4 + 1 <= var.cluster_count
  c5_create  = local.c5 + 1 <= var.cluster_count
  c6_create  = local.c6 + 1 <= var.cluster_count
  c7_create  = local.c7 + 1 <= var.cluster_count
  c8_create  = local.c8 + 1 <= var.cluster_count
  c9_create  = local.c9 + 1 <= var.cluster_count
  c10_create = local.c10 + 1 <= var.cluster_count
  c11_create = local.c11 + 1 <= var.cluster_count
  c12_create = local.c12 + 1 <= var.cluster_count
  c13_create = local.c13 + 1 <= var.cluster_count
  c14_create = local.c14 + 1 <= var.cluster_count
  c15_create = local.c15 + 1 <= var.cluster_count
  c16_create = local.c16 + 1 <= var.cluster_count
  c17_create = local.c17 + 1 <= var.cluster_count
  c18_create = local.c18 + 1 <= var.cluster_count
  c19_create = local.c19 + 1 <= var.cluster_count
  c20_create = local.c20 + 1 <= var.cluster_count
  c21_create = local.c21 + 1 <= var.cluster_count
  c22_create = local.c22 + 1 <= var.cluster_count
  c23_create = local.c23 + 1 <= var.cluster_count
  c24_create = local.c24 + 1 <= var.cluster_count
}
