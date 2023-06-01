resource "github_repository_file" "workload" {
  repository     = "team-main"
  file           = "workload/${var.repository_name}.yaml"
  content        = replace(local.workload_file_replaced, "TF_REPLACE_ENV_SUFFIX", var.enable_vault_config_env_suffixes ? "-dev" : "")
  branch         = "main"
  commit_message = "feat: adds ${var.repository_name} to deployed workloads"
}

resource "github_repository_file" "externalsecret_ssh_cd" {
  repository     = "team-main"
  file           = "workload/externalsecret-ssh-${local.full_tenant_name}-${var.repository_host}-${var.org_name}-${var.repository_name}.yaml"
  content        = local.externalsecret_ssh_cd_file_replaced
  branch         = "main"
  commit_message = "feat: adds ${var.repository_name} CD key to deployed workloads"
}

resource "github_repository_file" "externalsecret_ssh_ci" {
  repository     = "team-main"
  file           = "infra/externalsecret-ssh-${local.full_tenant_name}-${var.repository_host}-${var.org_name}-${var.repository_name}.yaml"
  content        = local.externalsecret_ssh_ci_file_replaced
  branch         = "main"
  commit_message = "feat: adds ${var.repository_name} CI key to deployed infra"
}
