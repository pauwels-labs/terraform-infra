output "master_username" {
  value     = module.this.cluster_master_username
  sensitive = true
}

output "master_password" {
  value     = module.this.cluster_master_password
  sensitive = true
}
