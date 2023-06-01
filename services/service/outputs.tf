output "repository_name" {
  value = var.repository_name
}

output "deploy_public_key_openssh" {
  value = [for k in tls_private_key.this : k.public_key_openssh]
}

output "deploy_public_key_pem" {
  value = [for k in tls_private_key.this : k.public_key_pem]
}

output "deploy_public_key_fingerprint_md5" {
  value = [for k in tls_private_key.this : k.public_key_fingerprint_md5]
}

output "deploy_public_key_fingerprint_sha256" {
  value = [for k in tls_private_key.this : k.public_key_fingerprint_sha256]
}

output "deploy_public_keys_map" {
  value = {
    for j, k in local.deploy_keys : k.name => {
      public_key_openssh            = tls_private_key.this[j].public_key_openssh
      public_key_pem                = tls_private_key.this[j].public_key_pem
      public_key_fingerprint_md5    = tls_private_key.this[j].public_key_fingerprint_md5
      public_key_fingerprint_sha256 = tls_private_key.this[j].public_key_fingerprint_sha256
    }
  }
}
