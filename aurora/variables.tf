variable "name" {
  description = "Name of the database cluster to make"
  type        = string
  validation {
    condition     = length(var.name) <= 26
    error_message = "Database cluster name must be 25 characters or less"
  }
}

variable "region" {
  description = "Region to deploy the database cluster to"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR range for the database's VPC"
  type        = string
}

variable "az_count" {
  description = "Number of AZs to deploy instances to in the region"
  type        = number
  default     = 2
  validation {
    condition     = var.az_count <= 5 && var.az_count >= 2
    error_message = "You must deploy to at least 2 but no more than 5 AZs"
  }
}

variable "use_ipv6" {
  description = "Set to true to setup VPC and database networking using ipv6"
  type        = bool
  default     = true
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

variable "databases_account_id" {
  description = "ID of the account to create the database in"
  type        = string
}

variable "databases_account_assume_role_name" {
  description = "Name of the role to assume in the databases account"
  type        = string
  default     = "OrganizationAccountAccessRole"
}
