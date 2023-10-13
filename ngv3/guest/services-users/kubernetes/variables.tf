// Organisation
variable "organisation_name" {
  description = "Name of the organisation"
  type        = string
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

// Users and their roles
variable "users" {
  description = "List of users and the roles they should be assigned with Kubernetes clusters in various environments"
  type        = list(object({
    username = string
    roles    = list(object({
      environment = string
      name        = string
    }))
  }))
}
