github_org_name  = "pauwels-labs"
repository_names = [
  "flux-infra",
  "team-main",
  "homepage",
  "redact-store",
  "redact-feed-api",
  "redact-feed-ui"
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
