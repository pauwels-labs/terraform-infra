github_org_name  = "pauwels-labs"
repository_names = [
  "flux-infra",
  "team-main"
]
deploy_keys = [
  {
    name = "ci"
    rw   = true
  },
  {
    name = "cd"
    rw   = false
  }
]
