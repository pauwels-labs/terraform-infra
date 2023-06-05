resource "github_repository_file" "workload" {
  repository     = "tenant-${var.tenant_name}"
  file           = "workload/${var.repository_name}.yaml"
  content        = replace(local.workload_file_replaced, "TF_REPLACE_ENV_SUFFIX", var.enable_vault_config_env_suffixes ? "-dev" : "")
  branch         = "main"
  commit_message = "feat: adds or removes ${var.repository_name} Kustomization in workloads (Terraform)"

  lifecycle {
    ignore_changes = [
      content
    ]
  }
}

resource "github_repository_file" "externalsecret_ssh_cd" {
  repository     = "tenant-${var.tenant_name}"
  file           = "workload/externalsecret-ssh-${local.full_tenant_name}-${var.repository_host}-${var.org_name}-${var.repository_name}.yaml"
  content        = local.externalsecret_ssh_cd_file_replaced
  branch         = "main"
  commit_message = "feat: adds or removes ${var.repository_name} CD key in workloads (Terraform)"
}

resource "github_repository_file" "externalsecret_ssh_ci" {
  repository     = "tenant-${var.tenant_name}"
  file           = "infra/externalsecret-ssh-${local.full_tenant_name}-${var.repository_host}-${var.org_name}-${var.repository_name}.yaml"
  content        = local.externalsecret_ssh_ci_file_replaced
  branch         = "main"
  commit_message = "feat: adds or removes ${var.repository_name} CI key in infra (Terraform)"
}
