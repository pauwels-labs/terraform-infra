// Account information
variable "cluster_account_id" {
  description = "ID of the account to create the cluster in"
  type        = string
}

variable "cluster_account_assume_role_name" {
  description = "Name of the role to assume in the cluster account"
  type        = string
  default     = "OrganizationAccountAccessRole"
}

variable "cluster_region" {
  description = "Region to deploy the cluster to"
  type        = string
  default     = "eu-west-1"
}
