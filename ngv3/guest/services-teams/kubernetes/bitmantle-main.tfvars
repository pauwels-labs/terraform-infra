organisation_name           = "bitmantle"
root_shared_realm_client_id = "bitmantle-shared"
idp_url                     = "https://identity.pauwelslabs.com"

team_name                 = "main"
created_role_environments = [
  {
    name = "shared"
  }
]
role_assignments          = [
  {
    roles = [
      {
        environment = "shared"
        name        = "reader"
      }
    ]
  },
  {
    subteam_name = "developers"
    roles        = [
      {
        environment = "shared"
        name        = "admin"
      },
      {
        environment = "shared"
        name        = "superadmin"
        is_root     = true
      }
    ]
  }
]
