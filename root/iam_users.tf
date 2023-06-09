# User accounts
resource "aws_iam_user" "pauwels" {
  name = "pauwels"
  tags = {
    full-name = "Alexandre Pauwels"
    email     = "alex@pauwelslabs.com"
  }  
}

resource "aws_iam_user" "sacksminnelli" {
  name = "sacksminnelli"
  tags = {
    full-name = "Hugh Whelan"
    email     = "hughwhelan210@gmail.com"
  }  
}

resource "aws_iam_user" "dzcostaneto" {
  name = "dzcostaneto"
  tags = {
    full-name = "Costa Neto"
    email     = "costa@pauwelslabs.com"
  }
}

resource "aws_iam_user" "kapdin" {
  name = "kapdin"
  tags = {
    full-name = "Kacper Dworski"
    email     = "kacperd75@gmail.com"
  }
}

# AWS Console access to user accounts
resource "aws_iam_user_login_profile" "pauwels" {
  user = aws_iam_user.pauwels.name
  pgp_key = "keybase:pauwels"
  password_length = 32
}

output "pauwels_login_encrypted_password" {
  value = aws_iam_user_login_profile.pauwels.encrypted_password
}

resource "aws_iam_user_login_profile" "sacksminnelli" {
  user = aws_iam_user.sacksminnelli.name
  pgp_key = "keybase:sacksminnelli"
  password_length = 32  
}

output "sacksminnelli_login_encrypted_password" {
  value = aws_iam_user_login_profile.sacksminnelli.encrypted_password
}

resource "aws_iam_user_login_profile" "dzcostaneto" {
  user = aws_iam_user.dzcostaneto.name
  pgp_key = "keybase:dzcostaneto"
  password_length = 32
}

output "dzcostaneto_login_encrypted_password" {
  value = aws_iam_user_login_profile.dzcostaneto.encrypted_password
}

resource "aws_iam_user_login_profile" "kapdin" {
  user = aws_iam_user.kapdin.name
  pgp_key = "keybase:kapdin"
  password_length = 32  
}

output "kapdin_login_encrypted_password" {
  value = aws_iam_user_login_profile.kapdin.encrypted_password
}

# Group memberships
resource "aws_iam_user_group_membership" "pauwels" {
  user = aws_iam_user.pauwels.name

  groups = [
    aws_iam_group.root_administrators.name,
    aws_iam_group.self_service_auth_with_mfa.name,
    aws_iam_group.terraform_backend.name,
  ]
}

resource "aws_iam_user_group_membership" "sacksminnelli" {
  user = aws_iam_user.sacksminnelli.name

  groups = []
}

resource "aws_iam_user_group_membership" "dzcostaneto" {
  user = aws_iam_user.dzcostaneto.name

  groups = [
    aws_iam_group.self_service_auth_with_mfa.name,
    aws_iam_group.workloads_sdlc_engineering_dev_administrators.name,
    aws_iam_group.deployments_prod_engineering_deployments_prod_administrators.name,
    aws_iam_group.terraform_backend.name
  ]
}

resource "aws_iam_user_group_membership" "kapdin" {
  user = aws_iam_user.kapdin.name

  groups = []
}
