// Cluster information
variable "cluster_count" {
  description = "Number of clusters ilke this to deploy"
  type        = number
  default     = 1
}

variable "cluster_region" {
  description = "Region to deploy the cluster to"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version of the cluster"
  type        = string
  default     = "1.22"
}

variable "cluster_service_cidr" {
  description = "CIDR range for the cluster's Service resources; should be in the 10.1xx.0.0/16 range"
  type        = string
}


// VPC settings
variable "cluster_vpc_cidr" {
  description = "CIDR range for the cluster's VPC"
  type        = string
}

variable "az_count" {
  description = "Number of availability zones to use"
  type        = number
  default     = 3
}

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

variable "keys_account_id" {
  description = "ID of the account to store encryption keys in"
  type        = string
}

variable "keys_account_assume_role_name" {
  description = "Name of the role to assume in the keys account"
  type        = string
  default     = "OrganizationAccountAccessRole"
}
