resource "github_repository" "this" {
  name                   = "tenant-${var.tenant_name}"
  auto_init              = false
  allow_rebase_merge     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true
  visibility             = var.tenant_repository_visibility

  template {
    owner                = var.org_name
    repository           = "template-tenant"
    include_all_branches = false
  }

  security_and_analysis {
    secret_scanning {
      status = var.tenant_repository_visibility == "public" ? "enabled" : "disabled"
    }
    secret_scanning_push_protection {
      status = var.tenant_repository_visibility == "public" ? "enabled" : "disabled"
    }
  }
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "tls_private_key" "this" {
  count = local.key_count

  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  count = local.key_count

  title      = local.deploy_keys[count.index].name
  repository = github_repository.this.name
  key        = tls_private_key.this[count.index].public_key_openssh
  read_only  = !local.deploy_keys[count.index].rw
}

resource "local_file" "deploy_private_key_openssh" {
  count = local.key_count

  content  = tls_private_key.this[count.index].private_key_openssh
  filename = "${path.root}/deploy_private_key_${github_repository.this.name}_${local.deploy_keys[count.index].name}.openssh"
}

resource "local_file" "deploy_private_key_pem" {
  count = local.key_count

  content  = tls_private_key.this[count.index].private_key_pem
  filename = "${path.root}/deploy_private_key_${github_repository.this.name}_${local.deploy_keys[count.index].name}.pem"
}
