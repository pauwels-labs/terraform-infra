resource "keycloak_user" "this" {
  for_each = local.users_map

  realm_id   = data.keycloak_realm.users.id
  username   = each.value.username
  email      = each.value.email
  first_name = each.value.first_name
  last_name  = each.value.last_name

  initial_password {
    value     = random_password.this[each.value.username].result
    temporary = true
  }
}

resource "random_password" "this" {
  for_each = local.users_map

  length = 32
}

resource "gpg_encrypted_message" "this" {
  for_each = local.users_map

  content     = random_password.this[each.value.username].result
  public_keys = [
    each.value.gpg_public_key
  ]
}

resource "keycloak_user_groups" "this" {
  for_each = local.users_map

  realm_id   = data.keycloak_realm.users.id
  user_id    = keycloak_user.this[each.key].id
  exhaustive = false
  group_ids  = [
    for team in each.value.teams : data.keycloak_group.teams["${team.team_name}${team.subteam_name == null ? "" : format("-%s", team.subteam_name)}"].id
  ]
}
