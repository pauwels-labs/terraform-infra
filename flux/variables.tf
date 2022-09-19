// Cluster information
variable "cluster_account_role_arn" {
  description = "Role ARN to use when fetching the kubeconfig file from EKS API; if not provided, this defaults to the role ARN used to create the cluster"
  type        = string
  default     = ""
}

variable "github_org_name" {
  description = "Name of the GitHub organization to deploy repositories to"
  type        = string
  default     = ""
}

variable "github_repository_name" {
  description = "Name of the base ops repository for flux"
  type        = string
  default     = "flux-infra"
}
