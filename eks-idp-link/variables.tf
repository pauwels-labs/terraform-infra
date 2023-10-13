// General
variable "remote_state_bucket_region" {
  description = "Region that the remote state buckets containing the EKS and IdP states are in"
  type        = string
  default     = "eu-west-1"
}

// EKS
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

// IdP
variable "idp_url" {
  description = "URL to the identity provider"
  type        = string
}

variable "organisation_name" {
  description = "Organisation whose IdP will be used to authenticate to the EKS clusters"
  type        = string
}

variable "environment_name" {
  description = "Environment to link to this cluster; what this means is that the IdP realm tied to that environment will be the realm authorised as an IdP provider to the cluster"
  type        = string
}
