locals {
  environments_map  = {
    for environment in var.environments : environment.name => environment
  }
}
