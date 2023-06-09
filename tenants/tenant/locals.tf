locals {
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
      "name" = var.tenant_name
    }
    "spec": {
      "targetNamespace" = "$${tenantnamespaceprefix}${var.tenant_name}"
      "postBuild" = {
        "substitute" = {
          "tenantname"     = var.tenant_name,
          "tenantrepohost" = local.tenant_repo_host_name
          "tenantrepoorg"  = var.tenant_repo_org_name
          "tenantreponame" = github_repository.this.name
          "tenantrepourl"  = "ssh://${local.ssh_clone_url_cleaned}"
          "tenantrepopath" = "base"
          "tenantrepobot"  = var.tenant_repo_bot_name
        }
      }      
    }
  }
  tenant_kustomization_yaml = yamldecode(file("${path.module}/tenant-kustomization.yaml"))

  env_map = merge({
    "infra" = { name = "infra" }
  }, {for env in var.tenant_envs : env.name => env})
  tenant_repo_host_name = replace(var.tenant_repo_domain, "/([^\\.]+)\\.([^\\.]+)$/", "$1")
}
