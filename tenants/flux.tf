resource "github_repository_file" "base_tenants_kustomization" {
  for_each = var.tenants_by_chunk

  repository     = "flux-infra"
  file           = "tenants/base/chunks/${each.key}/kustomization.yaml"
  content        = yamlencode({
    "apiVersion" = "kustomize.config.k8s.io/v1beta1"
    "kind"       = "Kustomization"
    "resources"  = [for tenant in var.tenants_by_chunk[each.key] : "${var.org_name}-${tenant.name}.yaml"]
  })
  branch         = "main"
  commit_message = "feat: adds or removes chunk kustomization in tenants/base/${each.key} (Terraform)"
}
