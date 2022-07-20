terraform {
  backend "s3" {
    bucket = "terraform-backend-20210130214355088200000001"
    key = "eks.tfstate"
    region = "eu-west-1"
    profile = "mfa"    
    role_arn = "arn:aws:iam::404672225309:role/TerraformBackend"    
    acl = "private"
    encrypt = true
    kms_key_id = "alias/terraform"
    workspace_key_prefix = "workspaces"
  }
}

provider "aws" {
  alias = "cluster"
  region = "eu-west-1"
  profile = "mfa"  
  assume_role {
    role_arn = local.cluster_account_role_arn
  }  
}

provider "aws" {
  alias = "keys"
  region = var.cluster_region
  profile = "mfa"  
  assume_role {
    role_arn = local.keys_account_role_arn
  }  
}

provider "kubernetes" {
  alias                  = "c0"
  host                   = module.eks[0].cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks[0].cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks[0].cluster_id, "--region", var.cluster_region, "--profile", "mfa", "--role-arn", local.cluster_account_role_arn]
  }
}

provider "kubernetes" {
  alias                  = "c1"
  host                   = module.eks[1].cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks[1].cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks[1].cluster_id, "--region", var.cluster_region, "--profile", "mfa", "--role-arn", local.cluster_account_role_arn]
  }
}
