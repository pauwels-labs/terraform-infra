variable "repository_host_name" {
  description = "The repository host to use, e.g. github"
  type        = string
  default     = "github"
}

variable "org_name" {
  description = "Name of the repository host organization to deploy the repository to"
  type        = string
}

variable "name" {
  description = "Name of the template to create; the repo name will be this value with the template- prefix"
  type        = string
}
