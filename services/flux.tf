resource "github_repository_file" "kustomization_infra" {
  repository          = "tenant-${var.tenant_name}"
  file                = "infra/kustomization.yaml"
  content             = yamlencode(local.kustomization_infra_yaml)
  branch              = "main"
  commit_message      = "feat: modifies the /infra kustomization"
  overwrite_on_create = true
}

resource "github_repository_file" "configmap_lighthouse_config" {
  repository          = "tenant-${var.tenant_name}"
  file                = "infra/configmap-lighthouse-config.yaml"
  content             = yamlencode(local.configmap_lighthouse_config_yaml)
  branch              = "main"
  commit_message      = "feat: modifies the /infra/configmap-lighthouse-config.yaml configmap"
  overwrite_on_create = true
}

resource "github_repository_file" "configmap_lighthouse_plugins" {
  repository          = "tenant-${var.tenant_name}"
  file                = "infra/configmap-lighthouse-plugins.yaml"
  content             = yamlencode(local.configmap_lighthouse_plugins_yaml)
  branch              = "main"
  commit_message      = "feat: modifies the /infra/configmap-lighthouse-plugins.yaml configmap"
  overwrite_on_create = true
}

resource "github_repository_file" "kustomization_env" {
  for_each = local.env_to_kustomization_map

  repository          = "tenant-${var.tenant_name}"
  file                = "${each.key}/kustomization.yaml"
  content             = yamlencode(each.value)
  branch              = "main"
  commit_message      = "feat: modifies the /${each.key} kustomization"
  overwrite_on_create = true
}
