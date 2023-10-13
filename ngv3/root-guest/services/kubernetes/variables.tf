// Root organisation
variable "root_organisation_name" {
  description = "Name of the root organisation to link to"
  type        = string
}

// Guest organisation
variable "guest_organisation_name" {
  description = "Name of the guest organisation to link"
  type        = string
}

variable "is_root" {
  description = "Set to true if the organisation being linked should have access to root roles"
}

// Keycloak
variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

// Clusters
variable "cluster_names" {
  description = "Name of the Kubernetes clusters"
  type        = set(string)
}

// Environment
variable "environment_name" {
  description = "Name of the environment the Kubernetes clusters are in"
  type        = string
}
