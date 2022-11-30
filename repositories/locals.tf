locals {
  repo_count      = length(var.repository_names)
  repo_key_count  = length(var.deploy_keys)
  total_key_count = local.repo_count * local.repo_key_count
}
