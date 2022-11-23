resource "random_id" "suffix" {
  count = 25

  byte_length = 4
}

locals {
  ecr_account_role_arn = "arn:aws:iam::${var.ecr_account_id}:role/${var.ecr_account_assume_role_name}"
  databases_account_role_arn = "arn:aws:iam::${var.databases_account_id}:role/${var.databases_account_assume_role_name}"
  dns_account_role_arn       = "arn:aws:iam::${var.dns_account_id}:role/${var.dns_account_assume_role_name}"
  keys_account_role_arn      = "arn:aws:iam::${var.keys_account_id}:role/${var.keys_account_assume_role_name}"
  cluster_account_role_arn   = "arn:aws:iam::${var.cluster_account_id}:role/${var.cluster_account_assume_role_name}"

  az_count                 = min(length(data.aws_availability_zones.available.names), var.az_count)
  subnet_count             = var.cluster_count * local.az_count
  nat_gateway_count        = var.ha_nat_gateways ? local.az_count : 1

  cluster_index                  = range(25)
  cluster_iam_role_name          = tolist([for i in local.cluster_index : "${local.cluster_names[i]}-cluster-${random_id.suffix[i].hex}"])
  cluster_encryption_policy_name = tolist([for i in local.cluster_index : "${local.cluster_names[i]}-cluster-ClusterEncryption-${random_id.suffix[i].hex}"])
  cluster_create                 = [for i in local.cluster_index : i + 1 <= var.cluster_count]
  cluster_names                  = [for i in local.cluster_index : "${var.cluster_name}-${i}"]

  clusters = slice([
    try(module.c0[0], null),
    try(module.c1[0], null),
    try(module.c2[0], null),
    try(module.c3[0], null),
    try(module.c4[0], null),
    try(module.c5[0], null),
    try(module.c6[0], null),
    try(module.c7[0], null),
    try(module.c8[0], null),
    try(module.c9[0], null),
    try(module.c10[0], null),
    try(module.c11[0], null),
    try(module.c12[0], null),
    try(module.c13[0], null),
    try(module.c14[0], null),
    try(module.c15[0], null),
    try(module.c16[0], null),
    try(module.c17[0], null),
    try(module.c18[0], null),
    try(module.c19[0], null),
    try(module.c20[0], null),
    try(module.c21[0], null),
    try(module.c22[0], null),
    try(module.c23[0], null),
    try(module.c24[0], null)
  ], 0, var.cluster_count)

  # Node security group rules
  nsgr_allow_postgres_databases_outbound = var.use_databases ? {
    allow_postgres_databases_outbound = {
      description      = "Egress all PostgreSQL traffic to the databases account"
      from_port        = 5432
      to_port          = 5432
      protocol         = "tcp"
      type             = "egress"
      ipv6_cidr_blocks = [data.aws_vpc.databases[0].ipv6_cidr_block]
    }
  }: {}
  nsgr_conditional_rules = merge(local.nsgr_allow_postgres_databases_outbound)
}
