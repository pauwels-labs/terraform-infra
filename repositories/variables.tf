variable "github_org_name" {
  description = "Name of the GitHub organization to deploy repositories to"
  type        = string
  default     = ""
}

variable "repository_names" {
  description = "List of all the repositories to manage in the organization"
  type        = list(string)
  default     = []
}

variable "deploy_keys" {
  description = "List of names of keys that will be added to each repo, along with a boolean value for each one determining if the deploy key should be read-write"
  type        = list(object({
    name = string,
    rw   = bool,
  }))
  default     = []
}
