module "team_kustomization_yaml" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [
    local.team_kustomization_yaml,
    local.team_kustomization_yaml_overrides
  ]
}

resource "github_repository_file" "team_kustomization" {
  repository     = "flux-infra"
  file           = "tenants/base/chunks/${var.team_chunk}/${var.team_name}.yaml"
  content        = yamlencode(module.team_kustomization_yaml.merged)
  branch         = "main"
  commit_message = "feat: adds or removes ${var.team_name} Kustomization in tenants/base (Terraform)"
}
