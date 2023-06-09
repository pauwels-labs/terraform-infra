resource "github_repository_file" "workload" {
  for_each = local.env_map

  repository     = "tenant-${var.tenant_name}"
  file           = "${local.collapse_envs ? var.collapse_envs_to : each.key}/${var.service_name}${local.collapse_envs ? "-${each.key}" : ""}.yaml"
  content        = replace(replace(replace(replace(local.workload_env_file_replaced, "TF_REPLACE_ENV_SUFFIX", local.collapse_envs ? "-${each.key}" : ""), "TF_REPLACE_ENV_NAME", each.key), "TF_REPLACE_DOMAIN", each.value.domain), "TF_REPLACE_SEMVER_RANGE", each.value.semver_range)
  branch         = "main"
  commit_message = "feat: modifies ${var.service_name} env-specific resources in /${each.key} (Terraform)"

  lifecycle {
    ignore_changes = [
      content
    ]
  }
}

resource "github_repository_file" "externalsecret_ssh_ci" {
  repository     = "tenant-${var.tenant_name}"
  file           = "infra/externalsecret-ssh-${var.tenant_name}-${local.service_repo_host_name}-${var.service_repo_org_name}-${var.service_name}.yaml"
  content        = local.externalsecret_ssh_ci_file_replaced
  branch         = "main"
  commit_message = "feat: adds or removes ${var.service_name} CI key in infra (Terraform)"
}
