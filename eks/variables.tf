// Cluster information
variable "cluster_count" {
  description = "Number of clusters like this to deploy"
  type        = number
  default     = 1
  validation {
    condition = var.cluster_count <= 25
    error_message = "Number of clusters cannot exceed 25 due to subnet masking"
  }
}

variable "cluster_region" {
  description = "Region to deploy the cluster to"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  validation {
    condition     = length(var.cluster_name) <= 26
    error_message = "Cluster name must be 26 characters or less due to IAM role name restrictions"
  }
}

variable "cluster_description" {
  description = "Short description for the purpose of the cluster to add as a tag"
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

variable "cluster_instance_types" {
  description = "Array of acceptable instance types to use for the cluster"
  type        = list
  default     = [
    "m5.large",
    "m5d.large",
    "m5a.large",
    "m5ad.large",
    "m5n.large",
    "m5dn.large",
    "m5zn.large",
    "t3.large",
    "t3a.large",
  ]
}

variable "use_ipv6" {
  description = "Set to true to setup cluster networking using ipv6"
  type        = bool
  default     = true
}

variable "instance_disk_size" {
  description = "Size of the root disk attached to cluster instances"
  type        = number
  default     = 100
}

variable "node_group_min_size" {
  description = "Minimum number of nodes in a node group"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Maximum number of nodes that the autoscaler can scale a node group to"
  type        = number
  default     = 5
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
  validation {
    condition     = var.az_count <= 5
    error_message = "The maximum number of availability zones in any AWS region is 5"
  }
}

variable "ha_nat_gateways" {
  description = "If set to true, each AZ will receive a separate NAT gateway"
  type        = bool
  default     = true
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

variable "dns_account_id" {
  description = "ID of the account to store DNS records in"
  type        = string
}

variable "dns_account_assume_role_name" {
  description = "Name of the role to assume in the DNS account"
  type        = string
  default     = "OrganizationAccountAccessRole"
}

// Flux installation settings
variable "use_flux" {
  description = "Set to true to manage CICD with Flux"
  type        = bool
  default     = true
}

variable "use_ecr" {
  description = "Set to true to use IAM roles to authenticate to an AWS ECR image and Helm registry"
  type        = bool
  default     = false
}

variable "ecr_arn" {
  description = "ARN of the ECR image and Helm registry to use; this can be cross-account and should be expressed in the form of a path, i.e. arn:aws:ecr:{region}:{account id}:repository/* to allow full access"
  type        = string
  default     = ""
}

variable "use_external_dns" {
  description = "Set to true to deploy external-dns and automate DNS record management"
  type        = bool
  default     = true
}
