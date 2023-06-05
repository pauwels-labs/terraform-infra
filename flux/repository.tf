# resource "github_repository" "this" {
#   name                   = var.repository_name
#   visibility             = var.repository_visibility
#   auto_init              = true
#   allow_rebase_merge     = false
#   allow_squash_merge     = false
#   delete_branch_on_merge = true

#   security_and_analysis {
#     secret_scanning {
#       status = var.repository_visibility == "public" ? "enabled" : "disabled"
#     }
#     secret_scanning_push_protection {
#       status = var.repository_visibility == "public" ? "enabled" : "disabled"
#     }
#   }
# }

# resource "github_branch_default" "this" {
#   repository = github_repository.this.name
#   branch     = "main"
# }

# resource "tls_private_key" "cd" {
#   count = local.cluster_count

#   algorithm   = "ECDSA"
#   ecdsa_curve = "P256"
# }

# resource "github_repository_deploy_key" "cd" {
#   count = local.cluster_count

#   title      = "cd"
#   repository = github_repository.this.name
#   key        = tls_private_key.this.public_key_openssh
#   read_only  = false
# }
