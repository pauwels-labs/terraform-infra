USER="$1"

terraform output -json users_encrypted_passwords | jq ".$1" | tr -d '"' | sed 's/\\n/\n/g' | keybase pgp decrypt && echo
