terraform {
  backend "s3" {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "keycloak.tfstate"
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
      version = "4.2.0"
    }
    gpg = {
      source = "invidian/gpg"
      version = "0.3.1"
    }
  }
}

provider "aws" {
  alias = "cluster"
  region = var.cluster_region
  profile = "mfa"
  assume_role {
    role_arn = local.cluster_account_role_arn
  }
}

provider "keycloak" {
  client_id     = "terraform"
  url           = "https://identity.pauwelslabs.com"
}

data "terraform_remote_state" "eks" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "eks.tfstate"
    region = var.cluster_region
    profile = "mfa"
    acl = "private"
    encrypt = true
    kms_key_id = "alias/terraform"
    workspace_key_prefix = "workspaces"
    assume_role = {
      role_arn = "arn:aws:iam::404672225309:role/TerraformBackend"
    }
  }
}
