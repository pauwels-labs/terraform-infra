output "users_encrypted_passwords" {
  sensitive = true

  value = {
    for username, encrypted_password in gpg_encrypted_message.this : username => encrypted_password.result
  }
}
