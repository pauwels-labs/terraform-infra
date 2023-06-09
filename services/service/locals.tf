locals {
  base_config_count      = local.collapse_envs ? length(var.service_envs) : 1
  collapse_envs          = length(var.collapse_envs_to) > 0 ? true : false
  key_count              = length(local.deploy_keys)
  cd_key_index           = index(local.deploy_keys.*.name, "cd")
  ci_key_index           = index(local.deploy_keys.*.name, "ci")
  deploy_keys            = concat(local.deploy_keys_default, var.additional_deploy_keys)
  deploy_keys_default    = [
    {
      name               = "ci"
      rw                 = true
    },
    {
      name               = "cd"
      rw                 = false
    }
  ]
  env_map                = merge({for env in var.service_envs : env.name => {
    name         = env.name,
    domain       = env.domain != null ? env.domain : var.service_domain,
    semver_range = env.semver_range != null ? env.semver_range : var.service_semver_range
  }})
  service_repo_host_name = replace(var.service_repo_domain, "/([^\\.]+)\\.([^\\.]+)$/", "$1")

  workload_env_file                   = file("${path.module}/workload-env.yaml")
  externalsecret_ssh_ci_file          = file("${path.module}/externalsecret-ssh-ci.yaml")
  workload_env_file_replaced          = replace(replace(replace(replace(replace(local.workload_env_file, "TF_REPLACE_NAME", var.service_name), "TF_REPLACE_TENANT_NAME", var.tenant_name), "TF_REPLACE_REPO_HOST_NAME", local.service_repo_host_name), "TF_REPLACE_ORG_NAME", var.service_repo_org_name), "TF_REPLACE_CONTAINER_REGISTRY_DOMAIN", var.container_registry_domain)
  externalsecret_ssh_ci_file_replaced = replace(replace(replace(replace(replace(local.externalsecret_ssh_ci_file, "TF_REPLACE_NAME", var.service_name), "TF_REPLACE_TENANT_NAME", var.tenant_name), "TF_REPLACE_REPO_HOST_NAME", local.service_repo_host_name), "TF_REPLACE_ORG_NAME", var.service_repo_org_name), "TF_REPLACE_CONTAINER_REGISTRY_DOMAIN", var.container_registry_domain)
}
