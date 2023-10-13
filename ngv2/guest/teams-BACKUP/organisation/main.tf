terraform {
  backend "s3" {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "guest-organisation.tfstate"
    region = "eu-west-1"
    profile = "mfa"    
    role_arn = "arn:aws:iam::404672225309:role/TerraformBackend"    
    acl = "private"
    encrypt = true
    kms_key_id = "alias/terraform"
    workspace_key_prefix = "workspaces"
  }
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
      version = "4.3.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.15.2"
    }
  }
}

provider "keycloak" {
  client_id = "terraform"
  url       = local.idp_url
}

provider "vault" {
  address = local.vault_url
}
