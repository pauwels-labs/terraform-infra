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

// Teams
variable "team_name" {
  description = "Name of the team being linked to Kubernetes roles"
  type        = string
}

variable "created_role_environments" {
  description = "List of environments that this team will have its own namespace in; if this team is being assigned roles from other teams but does not have its own namespaces, leave empty"
  type        = list(object({
    name = string
  }))
  default     = []
}

variable "role_assignments" {
  description = "List of roles that should be applied to this team and its subteams"
  type        = list(object({
    subteam_name = optional(string)
    roles        = list(object({
      team_name   = optional(string)
      environment = string
      name        = string
      is_root     = optional(bool, false)
      is_allteams = optional(bool, false)
    }))
  }))
  default     = []
}
