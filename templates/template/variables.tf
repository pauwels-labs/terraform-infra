variable "github_org_name" {
  description = "Name of the GitHub organization to deploy the repository to"
  type        = string
}

variable "name" {
  description = "Name of the template to create; the repo name will be this value with the template- prefix"
  type        = string
}
