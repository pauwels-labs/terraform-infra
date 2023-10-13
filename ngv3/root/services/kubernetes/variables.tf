// Organisation
variable "organisation_name" {
  description = "Name of the organisation"
  type        = string
}

// Keycloak
variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

// Cluster
variable "cluster_region" {
  description = "Region that the EKS clusters are in"
  type        = string
}

variable "cluster_account_id" {
  description = "ID of the account to create the cluster in"
  type        = string
}

variable "cluster_account_assume_role_name" {
  description = "Name of the role to assume in the cluster account"
  type        = string
  default     = "OrganizationAccountAccessRole"
}

variable "cluster_names" {
  description = "Name of the Kubernetes clusters"
  type        = set(string)
}

// Environment
variable "environment_name" {
  description = "Name of the environment the Kubernetes clusters are in"
  type        = string
}
