// Organisation
variable "organisation_name" {
  description = "Name of the organisation"
  type        = string
}

variable "is_root" {
  description = "Set to true if root roles should be applied; even if this is set to true, these roles are only created in the user realm, they must be linked to the shared realm via identity provider role mappings in order to actually be able to receive them"
}

// Root organisation
variable "root_shared_realm_client_id" {
  description = "ID of the client in this organisation's users realm that is used to authenticate to the root organisation's shared infrastructure realm"
  type        = string
}

// Keycloak
variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

// Environment
variable "environment_name" {
  description = "Name of the environment the Kubernetes clusters are in"
  type        = string
}
