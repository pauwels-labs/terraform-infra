output "flux_infra_repository_name" {
  value = github_repository.flux_infra.name
}

output "team_main_repository_name" {
  value = github_repository.team_main.name
}

output "team_main_deploy_ssh_public_key_openssh" {
  value = tls_private_key.team_main_deploy_key.public_key_openssh
}

output "team_main_deploy_ssh_public_key_pem" {
  value = tls_private_key.team_main_deploy_key.public_key_pem
}

output "team_main_deploy_ssh_public_key_fingerprint_md5" {
  value = tls_private_key.team_main_deploy_key.public_key_fingerprint_md5
}

output "team_main_deploy_ssh_public_key_fingerprint_sha256" {
  value = tls_private_key.team_main_deploy_key.public_key_fingerprint_sha256
}

# output "team_main_deploy_ssh_private_key_openssh" {
#   value     = tls_private_key.team_main_deploy_key.private_key_openssh
#   sensitive = true
# }

# output "team_main_deploy_ssh_private_key_pem" {
#   value     = tls_private_key.team_main_deploy_key.private_key_pem
#   sensitive = true
# }
