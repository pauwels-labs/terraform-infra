locals {
  full_tenant_name = "${var.org_name}-${var.tenant_name}"
  hmac_token_names = toset(concat(["primary"], tolist(var.additional_hmac_tokens)))

  key_count           = length(local.deploy_keys)
  cd_key_index        = index(local.deploy_keys.*.name, "cd")
  ci_key_index        = index(local.deploy_keys.*.name, "ci")
  deploy_keys         = concat(local.deploy_keys_default, var.additional_deploy_keys)
  deploy_keys_default = [
    {
      name = "ci"
      rw   = true
    },
    {
      name = "cd"
      rw   = true
    }
  ]

  ssh_clone_url_cleaned = replace(github_repository.this.ssh_clone_url, "/([^:]+):([^:]+)/", "$1/$2")
  tenant_kustomization_yaml_overrides = {
    "metadata" = {
      "name" = local.full_tenant_name
    }
    "spec": {
      "targetNamespace" = "$${tenantnamespaceprefix}${local.full_tenant_name}"
      "postBuild" = {
        "substitute" = {
          "tenantname"     = local.full_tenant_name,
          "tenantrepohost" = var.repository_bot_host
          "tenantrepoorg"  = var.org_name
          "tenantreponame" = github_repository.this.name
          "tenantrepourl"  = "ssh://${local.ssh_clone_url_cleaned}"
          "tenantrepopath" = "base"
          "tenantrepobot"  = var.repository_bot_name
        }
      }      
    }
  }
  tenant_kustomization_yaml = yamldecode(file("${path.module}/tenant-kustomization.yaml"))
}
