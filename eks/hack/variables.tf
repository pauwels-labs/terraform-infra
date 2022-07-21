// Cluster information
variable "az_count" {
  type = number
}

variable "cluster_account_role_arn" {
  type = string
}

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

variable "cluster_endpoint_private_access" {
  type = bool
}

variable "cluster_endpoint_public_access" {
  type = bool
}

variable "cluster_ip_family" {
  type = string
}

variable "cluster_service_ipv4_cidr" {
  type = string
}

variable "cluster_addons" {
  type = map
}

variable "encryption_keys" {
  type = list
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list
}

variable "manage_aws_auth_configmap" {
  type = bool
}

variable "eks_managed_node_group_defaults" {
  type = object({
    ami_type = string
    platform = string
    capacity_type = string
    instance_types = list(string)
  })
}

variable "disk_size" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}
