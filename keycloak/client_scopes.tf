resource "keycloak_openid_client_scope" "groups" {
  realm_id               = keycloak_realm.pauwels_labs_main.id
  name                   = "groups"
  description            = "When requested, this scope will map a user's group memberships to a claim"
  include_in_token_scope = true
  consent_screen_text    = false
}

resource "keycloak_openid_group_membership_protocol_mapper" "groups" {
  realm_id            = keycloak_realm.pauwels_labs_main.id
  client_scope_id     = keycloak_openid_client_scope.groups.id
  name                = "groups"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
  full_path           = true
  claim_name          = "groups"
}
