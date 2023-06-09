module "tenant_kustomization_yaml" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [
    local.tenant_kustomization_yaml,
    local.tenant_kustomization_yaml_overrides
  ]
}

resource "github_repository_file" "tenant_kustomization" {
  repository     = "flux-infra"
  file           = "tenants/base/chunks/${var.tenant_chunk}/${var.tenant_name}.yaml"
  content        = yamlencode(module.tenant_kustomization_yaml.merged)
  branch         = "main"
  commit_message = "feat: adds or removes ${var.tenant_name} Kustomization in tenants/base (Terraform)"
}
