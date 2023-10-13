root_organisation_name  = "bitmantle"
guest_organisation_name = "bitmantle"
idp_url                 = "https://identity.pauwelslabs.com"
team_name               = "main"
environments_clusters   = [
  {
    environment_name  = "shared"
    create_team_roles = true
    clusters          = [
      "lefranc"
    ]
  }
]
