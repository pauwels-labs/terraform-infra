organisation_name           = "bitmantle"
root_shared_realm_client_id = "bitmantle-shared"
idp_url                     = "https://identity.pauwelslabs.com"

users = [
  {
    username = "pauwels"
    roles    = [
      {
        environment = "shared"
        name        = "superadmin"
      }
    ]
  }
]
