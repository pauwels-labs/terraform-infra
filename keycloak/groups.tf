resource "keycloak_group" "tenant_pauwels_labs_main" {
  realm_id   = keycloak_realm.pauwels_labs_main.id
  name       = "tenant-pauwels-labs-main"
  attributes = {
    "aws_federated_auth_user_id" = "AROAT7XKPNHZO5AVLLWJY:pauwels-labs-main"
    "tenant_name" = "pauwels-labs-main"
    "aws_tags" = "{\"principal_tags\":{\"tenant_name\":[\"pauwels-labs-main\"]},\"transitive_tag_keys\":[\"tenant_name\"]}"
  }
}

resource "keycloak_group" "tenant_pauwels_labs_main_root" {
  realm_id  = keycloak_realm.pauwels_labs_main.id
  parent_id = keycloak_group.tenant_pauwels_labs_main.id
  name      = "root"
}

resource "keycloak_group" "tenant_pauwels_labs_main_root_admins" {
  realm_id  = keycloak_realm.pauwels_labs_main.id
  parent_id = keycloak_group.tenant_pauwels_labs_main_root.id
  name      = "admins"
  attributes = {
    "grafana_org_id" = "1"
    "grafana_role" = "GrafanaAdmin"
  }
}

resource "keycloak_group" "tenant_pauwels_labs_main_root_writers" {
  realm_id  = keycloak_realm.pauwels_labs_main.id
  parent_id = keycloak_group.tenant_pauwels_labs_main_root.id
  name      = "writers"
  attributes = {
    "grafana_org_id" = "2"
  }
}

resource "keycloak_group" "tenant_pauwels_labs_main_root_readers" {
  realm_id  = keycloak_realm.pauwels_labs_main.id
  parent_id = keycloak_group.tenant_pauwels_labs_main_root.id
  name      = "readers"
}

resource "keycloak_group" "tenant_pauwels_labs_main_kubernetes" {
  realm_id  = keycloak_realm.pauwels_labs_main.id
  parent_id = keycloak_group.tenant_pauwels_labs_main.id
  name      = "kubernetes"
}

resource "keycloak_group" "tenant_pauwels_labs_main_kubernetes_admins" {
  realm_id  = keycloak_realm.pauwels_labs_main.id
  parent_id = keycloak_group.tenant_pauwels_labs_main_kubernetes.id
  name      = "admins"
}

resource "keycloak_group" "tenant_pauwels_labs_main_kubernetes_writers" {
  realm_id  = keycloak_realm.pauwels_labs_main.id
  parent_id = keycloak_group.tenant_pauwels_labs_main_kubernetes.id
  name      = "writers"
}

resource "keycloak_group" "tenant_pauwels_labs_main_kubernetes_readers" {
  realm_id  = keycloak_realm.pauwels_labs_main.id
  parent_id = keycloak_group.tenant_pauwels_labs_main_kubernetes.id
  name      = "readers"
}
