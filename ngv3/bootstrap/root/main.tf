# Backend
# Initially comment this out before the S3 bucket and dynamodb table are provisioned
provider "aws" {
  region  = "eu-west-1"
  profile = "mfa"  

  assume_role {
    role_arn = "arn:aws:iam::404672225309:role/RootAdministrator"
  }  
}

terraform {
  backend "s3" {
    bucket               = "terraform-backend-20210130214355088200000001"
    key                  = "root.tfstate"
    region               = "eu-west-1"
    profile              = "mfa"    
    role_arn             = "arn:aws:iam::404672225309:role/TerraformBackend"
    acl                  = "private"
    encrypt              = true
    kms_key_id           = "alias/terraform"
    workspace_key_prefix = "workspaces"
  }
}

resource "aws_kms_key" "terraform" {
  description             = "Key for encrypting the Terraform backend"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags                    = {
    Name = "terraform"
  }  
}

resource "aws_kms_alias" "terraform" {
  name          = "alias/terraform"
  target_key_id = aws_kms_key.terraform.key_id
}

resource "aws_s3_bucket" "terraform_backend" {
  bucket_prefix = "terraform-backend-"
  tags          = {
    Name = "Terraform Backend"
  }
}

resource "aws_s3_bucket_versioning" "terraform_backend" {
  bucket = aws_s3_bucket.terraform_backend.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_backend" {
  bucket = aws_s3_bucket.terraform_backend.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_acl" "terraform_backend" {
  bucket = aws_s3_bucket.terraform_backend.id
  acl    = "private"
}
