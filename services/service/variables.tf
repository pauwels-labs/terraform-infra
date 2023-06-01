variable "repository_host" {
  description = "The Git repository host, e.g. GitHub"
  type        = string
  default     = "github"
}

variable "org_name" {
  description = "Name of the organization owning the repository"
  type        = string
}

variable "tenant_name" {
  description = "Name of the tenant that will own the service"
  type        = string
}

variable "repository_name" {
  description = "Name of the service to create"
  type        = string
}

variable "template_name" {
  description = "Name of the template to inherit from"
  type        = string
}

variable "additional_deploy_keys" {
  description = "List of names of deploy keys that will be added to the service's repo on top of the default keys, along with a boolean value for each one determining if the deploy key should be read-write"
  type        = list(object({
    name = string,
    rw   = bool,
  }))
  default     = []
}

variable "known_hosts" {
  description = "Content of known_hosts file for placing in the repository SSH configuration"
  type        = string
  default     = <<EOT
github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
EOT
}

variable "enable_vault_config_env_suffixes" {
  description = "This is used to enable having multiple environments in a single cluster; the name of the env will be added as a suffix to the name of the app in the config path"
  type        = bool
  default     = false
}

variable "container_registry_domain" {
  description = "The domain of the container registry where the service artifacts will be stored"
  type        = string
}

variable "ci_webhook_domain" {
  description = "The domain (without scheme or trailing slash) of the CI webhook"
  type        = string
}

variable "hmac_token_name" {
  description = "The HMAC token to use"
  type        = string
  default     = "primary"
}
