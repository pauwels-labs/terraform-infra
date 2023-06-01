resource "github_repository" "this" {
  name                   = "template-${var.name}"
  auto_init              = true
  allow_rebase_merge     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true
  is_template            = true
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = "main"
}
