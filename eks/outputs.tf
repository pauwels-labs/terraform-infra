output "cluster_count" {
  value = var.cluster_count
}

output "cluster_base_name" {
  value = var.cluster_name
}

output "cluster_region" {
  value = var.cluster_region
}

output "cluster_account_id" {
  value = var.cluster_account_id
}

output "cluster_creator_role_arn" {
  value = local.cluster_account_role_arn
}

output "clusters" {
  value = local.clusters
}
