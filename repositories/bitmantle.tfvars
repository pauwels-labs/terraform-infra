github_org_name  = "bitmantle"
repository_names = [
  "flux-infra"
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
