// Root organisation
variable "root_organisation_name" {
  description = "Name of the root organisation"
  type        = string
}

// Guest organisation
variable "guest_organisation_name" {
  description = "Name of the guest organisation"
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

variable "environments_clusters" {
  description = "List of environments and the clusters associated with them"
  type        = list(object({
    environment_name  = string
    create_team_roles = bool
    clusters          = set(string)
  }))
  default     = []
}
