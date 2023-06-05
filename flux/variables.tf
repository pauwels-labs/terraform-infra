// Cluster information
variable "repository_host_domain" {
  description = "The domain of the repository host to use, e.g. github.com"
  type        = string
  default     = "github.com"

  validation {
    condition = var.repository_host_domain == "github.com"
    error_message = "Currently, only \"github.com\" is a supported repository host"
  }
}

variable "org_name" {
  description = "Name of the organization to bootstrap for"
  type        = string
}

variable "repository_name" {
  description = "Name of the repository to store flux infrastructure in"
  type        = string
  default     = "flux-infra"
}

variable "repository_visibility" {
  description = "Visibility of the flux infrastructure repository"
  type    = string
  default = "private"
}

variable "cluster_account_role_arn" {
  description = "Role ARN to use when fetching the kubeconfig file from EKS API; if not provided, this defaults to the role ARN used to create the cluster"
  type        = string
  default     = ""
}
