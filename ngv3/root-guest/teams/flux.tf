resource "github_repository_file" "base_teams_kustomization" {
  for_each = var.teams_by_chunk

  repository     = "flux-infra"
  file           = "tenants/base/chunks/${each.key}/kustomization.yaml"
  content        = yamlencode({
    "apiVersion" = "kustomize.config.k8s.io/v1beta1"
    "kind"       = "Kustomization"
    "resources"  = [for team in var.teams_by_chunk[each.key] : "${var.organisation_name}-${team.name}.yaml"]
  })
  branch         = "main"
  commit_message = "feat: adds or removes chunk kustomization in tenants/base/${each.key} (Terraform)"
}
