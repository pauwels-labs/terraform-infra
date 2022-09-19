resource "github_repository" "flux_infra" {
  name      = local.flux_infra_repository_name
  auto_init = true
}

resource "github_branch_default" "main" {
  repository = github_repository.flux_infra.name
  branch     = "main"
}
