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
  team_kustomization_yaml_overrides = {
    "metadata" = {
      "name" = var.team_name
    }
    "spec": {
      "targetNamespace" = "$${tenantnamespaceprefix}${var.team_name}"
      "postBuild" = {
        "substitute" = {
          "organisation_name"       = var.organisation_name
          "team_name"               = var.team_name
          "repository_host"         = local.repository_host_without_tld
          "repository_organisation" = var.repository_organisation_name
          "repository_name"         = github_repository.this.name
          "repository_url"          = "ssh://${local.ssh_clone_url_cleaned}"
          "repository_path"         = "base"
          "repository_bot_name"     = var.repository_bot_name
        }
      }      
    }
  }
  team_kustomization_yaml = yamldecode(file("${path.module}/team-kustomization.yaml"))

  env_map = merge({
    "infra" = { name = "infra" }
  }, {for env in var.team_envs : env.name => env})
  repository_host_without_tld = replace(var.repository_domain, "/([^\\.]+)\\.([^\\.]+)$/", "$1")
  repository_host_without_dot = replace(var.repository_domain, ".", "")
}
