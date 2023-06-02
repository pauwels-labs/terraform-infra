resource "github_repository_file" "kustomization_workload" {
  repository          = "team-${var.tenant_name}"
  file                = "workload/kustomization.yaml"
  content             = yamlencode(local.kustomization_workload_yaml)
  branch              = "main"
  commit_message      = "feat: adds or removes the workloads kustomization"
  overwrite_on_create = true
}

resource "github_repository_file" "kustomization_infra" {
  repository          = "team-${var.tenant_name}"
  file                = "infra/kustomization.yaml"
  content             = yamlencode(local.kustomization_infra_yaml)
  branch              = "main"
  commit_message      = "feat: adds or removes the infra kustomization"
  overwrite_on_create = true
}

# resource "github_repository_file" "workload_secret_kustomization" {
#   repository          = "team-main"
#   file                = "workload/kustomization.yaml"
#   content             = contains(local.workload_kustomization_yaml.resources, "externalsecret-ssh-${local.full_tenant_name}-${var.repository_host}-${var.org_name}-${var.repository_name}.yaml") ? data.github_repository_file.workload_kustomization.content : yamlencode({for k, v in local.workload_kustomization_yaml : k => k == "resources" ? concat(v, ["externalsecret-ssh-${local.full_tenant_name}-${var.repository_host}-${var.org_name}-${var.repository_name}.yaml"]) : v})
#   branch              = "main"
#   commit_message      = "feat: adds ${var.repository_name} ssh secret file to workload kustomization"
#   overwrite_on_create = true
# }

# resource "github_repository_file" "infra_kustomization" {
#   repository          = "team-main"
#   file                = "infra/kustomization.yaml"
#   content             = contains(local.infra_kustomization_yaml.resources, "externalsecret-ssh-${local.full_tenant_name}-${var.repository_host}-${var.org_name}-${var.repository_name}.yaml") ? data.github_repository_file.infra_kustomization.content : yamlencode({for k, v in local.infra_kustomization_yaml : k => k == "resources" ? concat(v, ["externalsecret-ssh-${local.full_tenant_name}-${var.repository_host}-${var.org_name}-${var.repository_name}.yaml"]) : v})
#   branch              = "main"
#   commit_message      = "feat: adds ${var.repository_name} new infra files to infra kustomization"  
#   overwrite_on_create = true
# }
