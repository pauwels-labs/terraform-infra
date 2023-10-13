data "keycloak_openid_client" "environments" {
  for_each = local.environments_map

  realm_id  = "${var.organisation_name}-${each.value.name}"
  client_id = coalesce(each.value.client_id, "vault")
}

resource "vault_jwt_auth_backend" "environments" {
  for_each = local.environments_map

  path                = "${each.value.name}"
  type                = "oidc"
  description         = "OIDC auth for the ${each.value.name} environment"
  oidc_discovery_url  = each.value.oidc_discovery_url
  oidc_client_id      = data.keycloak_openid_client.environments[each.value.name].client_id
  oidc_client_secret  = data.keycloak_openid_client.environments[each.value.name].client_secret
  oidc_response_mode  = "query"
  oidc_response_types = [
    "code"
  ]
  bound_issuer        = each.value.oidc_discovery_url

  tune {
    default_lease_ttl  = "72h"
    max_lease_ttl      = "72h"
    listing_visibility = "unauth"
    token_type         = "default-service"
  }
}
