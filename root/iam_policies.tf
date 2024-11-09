data "aws_iam_policy" "administrator_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy_document" "root_administrator_assume_role_policy" {
  statement {
    sid = "AllowRootUsersToAssumeThisRole"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::404672225309:root"
      ]	
    }
    actions = [
      "sts:AssumeRole"      
    ]    
  }
}

resource "aws_iam_policy" "iam_user_change_password" {
  name = "IAMUserChangePasswordAndListOwnUser"
  path = "/"
  description = "Grants user permissions to view and change their own password"
  policy = data.aws_iam_policy_document.iam_user_change_password.json
}

data "aws_iam_policy_document" "iam_user_change_password" {
  statement {
    sid = "ViewAccountPasswordRequirements"
    effect = "Allow"
    actions = [
      "iam:GetAccountPasswordPolicy"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "ChangeOwnPassword"
    effect = "Allow"
    actions = [
      "iam:GetUser",
      "iam:ListUsers",
      "iam:ChangePassword",
      "iam:GetLoginProfile"
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}"
    ]
  }
  statement {
    sid = "ListUsers"
    effect = "Allow"
    actions = [
      "iam:ListUsers"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "terraform_backend_assume_role_policy" {
  statement {
    sid = "AllowRootUsersToAssumeThisRole"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
	"arn:aws:iam::404672225309:root"
      ]	
    }
    actions = [
      "sts:AssumeRole"      
    ]    
  }
}

data "aws_iam_policy_document" "grant_root_administrator_role" {
  statement {
    sid = "AllowAssumeRootAdministratorRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::404672225309:role/RootAdministrator",
      "arn:aws:iam::${aws_organizations_account.artifacts_prod.id}:role/OrganizationAccountAccessRole",
      "arn:aws:iam::${aws_organizations_account.dns_prod.id}:role/OrganizationAccountAccessRole",
      "arn:aws:iam::${aws_organizations_account.keys_prod.id}:role/OrganizationAccountAccessRole",
      "arn:aws:iam::${aws_organizations_account.vpn_prod.id}:role/OrganizationAccountAccessRole",
      "arn:aws:iam::${aws_organizations_account.databases_prod.id}:role/OrganizationAccountAccessRole",
      "arn:aws:iam::${aws_organizations_account.engineering_dev.id}:role/OrganizationAccountAccessRole",
      "arn:aws:iam::${aws_organizations_account.engineering_deployments_prod.id}:role/OrganizationAccountAccessRole",
      "arn:aws:iam::${aws_organizations_account.sandbox_pirate_cloud.id}:role/OrganizationAccountAccessRole",
    ]
  }
}

resource "aws_iam_policy" "grant_root_administrator_role" {
  name = "GrantAccessToRootAdministratorRole"
  path = "/"
  description = "Grants access to the RootAdministrator role in the Root account"

  policy = data.aws_iam_policy_document.grant_root_administrator_role.json
}

data "aws_iam_policy_document" "decrypted_rw_on_terraform_backend_bucket" {
  statement {
    sid = "AllowS3ListBuckets"
    effect = "Allow"    
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.terraform_backend.arn
    ]
  }
  statement {
    sid = "AllowS3RWOnTerraformBucket"
    effect = "Allow"    
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion"
    ]
    resources = [
      "${aws_s3_bucket.terraform_backend.arn}/*"
    ]
  }
  statement {
    sid = "AllowUseOfDecryptionKey"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = [
      "arn:aws:kms:eu-west-1:404672225309:key/63d199b0-0d1c-4bc4-b326-88e62c151b40"
    ]    
  }  
}

resource "aws_iam_policy" "grant_decrypted_rw_on_terraform_backend_bucket" {
  name = "GrantDecryptedRWAccessToTerraformBackendBucket"
  path = "/"
  description = "Grants RW access to the terraform backed bucket"

  policy = data.aws_iam_policy_document.decrypted_rw_on_terraform_backend_bucket.json
}

data "aws_iam_policy_document" "grant_terraform_backend_role" {
  statement {
    sid = "AllowAssumeTerraformBackendRole"
    effect = "Allow"    
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::404672225309:role/TerraformBackend"
    ]
  }
}

resource "aws_iam_policy" "grant_terraform_backend_role" {
  name = "GrantAccessToTerraformBackendRole"
  path = "/"
  description = "Grants access to the Terraform-related S3 and DynamodDB resources required to run the backend"

  policy = data.aws_iam_policy_document.grant_terraform_backend_role.json
}

data "aws_iam_policy_document" "grant_infrastructure_prod_artifacts_prod_administrator_role" {
  statement {
    sid = "AllowAssumeOrganizationAccountAccessRole"
    effect = "Allow"    
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${aws_organizations_account.artifacts_prod.id}:role/OrganizationAccountAccessRole"
    ]
  }
}

resource "aws_iam_policy" "grant_infrastructure_prod_artifacts_prod_administrator_role" {
  name = "GrantAccessToInfrastructureProdArtifactsProdAdministratorRole"
  path = "/"
  description = "Grants access to the OrganizationAccountAccessRole in the Infrastructure/Prod/Artifacts Prod account"

  policy = data.aws_iam_policy_document.grant_infrastructure_prod_artifacts_prod_administrator_role.json
}

data "aws_iam_policy_document" "grant_infrastructure_prod_dns_prod_administrator_role" {
  statement {
    sid = "AllowAssumeOrganizationAccountAccessRole"
    effect = "Allow"    
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${aws_organizations_account.dns_prod.id}:role/OrganizationAccountAccessRole"
    ]
  }
}

resource "aws_iam_policy" "grant_infrastructure_prod_dns_prod_administrator_role" {
  name = "GrantAccessToInfrastructureProdDNSProdAdministratorRole"
  path = "/"
  description = "Grants access to the OrganizationAccountAccessRole in the Infrastructure/Prod/DNS Prod account"

  policy = data.aws_iam_policy_document.grant_infrastructure_prod_dns_prod_administrator_role.json
}

data "aws_iam_policy_document" "grant_infrastructure_prod_keys_prod_administrator_role" {
  statement {
    sid = "AllowAssumeOrganizationAccountAccessRole"
    effect = "Allow"    
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${aws_organizations_account.keys_prod.id}:role/OrganizationAccountAccessRole"
    ]
  }
}

resource "aws_iam_policy" "grant_infrastructure_prod_keys_prod_administrator_role" {
  name = "GrantAccessToInfrastructureProdKeysProdAdministratorRole"
  path = "/"
  description = "Grants access to the OrganizationAccountAccessRole in the Infrastructure/Prod/Keys Prod account"

  policy = data.aws_iam_policy_document.grant_infrastructure_prod_keys_prod_administrator_role.json
}

data "aws_iam_policy_document" "grant_infrastructure_prod_vpn_prod_administrator_role" {
  statement {
    sid = "AllowAssumeOrganizationAccountAccessRole"
    effect = "Allow"    
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${aws_organizations_account.vpn_prod.id}:role/OrganizationAccountAccessRole"
    ]
  }
}

resource "aws_iam_policy" "grant_infrastructure_prod_vpn_prod_administrator_role" {
  name = "GrantAccessToInfrastructureProdVPNProdAdministratorRole"
  path = "/"
  description = "Grants access to the OrganizationAccountAccessRole in the Infrastructure/Prod/VPN Prod account"

  policy = data.aws_iam_policy_document.grant_infrastructure_prod_vpn_prod_administrator_role.json
}

data "aws_iam_policy_document" "grant_infrastructure_prod_databases_prod_administrator_role" {
  statement {
    sid = "AllowAssumeOrganizationAccountAccessRole"
    effect = "Allow"    
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${aws_organizations_account.databases_prod.id}:role/OrganizationAccountAccessRole"
    ]
  }
}

resource "aws_iam_policy" "grant_infrastructure_prod_databases_prod_administrator_role" {
  name = "GrantAccessToInfrastructureProdDatabasesProdAdministratorRole"
  path = "/"
  description = "Grants access to the OrganizationAccountAccessRole in the Infrastructure/Prod/Databases Prod account"

  policy = data.aws_iam_policy_document.grant_infrastructure_prod_databases_prod_administrator_role.json
}

data "aws_iam_policy_document" "grant_workloads_sdlc_engineering_dev_administrator_role" {
  statement {
    sid = "AllowAssumeOrganizationAccountAccessRole"
    effect = "Allow"    
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${aws_organizations_account.engineering_dev.id}:role/OrganizationAccountAccessRole"
    ]
  }
}

resource "aws_iam_policy" "grant_workloads_sdlc_engineering_dev_administrator_role" {
  name = "GrantAccessToWorkloadsSDLCEngineeringDevAdministratorRole"
  path = "/"
  description = "Grants access to the OrganizationAccountAccessRole in the Workloads/SDLC/Engineering Dev account"

  policy = data.aws_iam_policy_document.grant_workloads_sdlc_engineering_dev_administrator_role.json
}

data "aws_iam_policy_document" "grant_deployments_prod_engineering_deployments_prod_administrator_role" {
  statement {
    sid = "AllowAssumeOrganizationAccountAccessRole"
    effect = "Allow"    
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${aws_organizations_account.engineering_deployments_prod.id}:role/OrganizationAccountAccessRole"
    ]
  }
}

resource "aws_iam_policy" "grant_deployments_prod_engineering_deployments_prod_administrator_role" {
  name = "GrantAccessToDeploymentsProdEngineeringDeploymentsProdAdministratorRole"
  path = "/"
  description = "Grants access to the OrganizationAccountAccessRole in the Deployments/Prod/Engineering Deployments Prod account"

  policy = data.aws_iam_policy_document.grant_deployments_prod_engineering_deployments_prod_administrator_role.json
}

data "aws_iam_policy_document" "grant_sandbox_pirate_cloud_administrator_role" {
  statement {
    sid = "AllowAssumeOrganizationAccountAccessRole"
    effect = "Allow"    
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${aws_organizations_account.sandbox_pirate_cloud.id}:role/OrganizationAccountAccessRole"
    ]
  }
}

resource "aws_iam_policy" "grant_sandbox_pirate_cloud_administrator_role" {
  name = "GrantAccessToSandboxPirateCloudAdministratorRole"
  path = "/"
  description = "Grants access to the OrganizationAccountAccessRole in the Sandbox/Pirate Cloud account"

  policy = data.aws_iam_policy_document.grant_sandbox_pirate_cloud_administrator_role.json
}

data "aws_iam_policy_document" "grant_self_service_auth_with_mfa" {
  statement {
    sid = "AllowViewAccountInfo"    
    effect = "Allow"    
    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices"
    ]
    resources = [
      "*"      
    ]    
  }
  statement {
    sid = "AllowManageOwnPasswords"    
    effect = "Allow"    
    actions = [
      "iam:ChangePassword",
      "iam:CreateLoginProfile",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:GetUser",
      "iam:UpdateLoginProfile"
    ]
    resources = [
      "*"      
    ]    
  }
  statement {
    sid = "AllowManageOwnAccessKeys"
    effect = "Allow"
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey"
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}"
    ]      
  }
  statement {
    sid = "AllowManageOwnSigningCertificates"
    effect = "Allow"
    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate"
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}"
    ]      
  }
  statement {
    sid = "AllowManageOwnSSHPublicKeys"
    effect = "Allow"
    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}"
    ]      
  }
  statement {
    sid = "AllowManageOwnGitCredentials"
    effect = "Allow"
    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential"
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}"
    ]      
  }
  statement {
    sid = "AllowManageOwnVirtualMFADevice"
    effect = "Allow"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice"
    ]
    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}"
    ]      
  }
  statement {
    sid = "AllowManageOwnUserMFA"
    effect = "Allow"
    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice"
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}"
    ]      
  }
  statement {
    sid = "DenyAllExceptListedIfNoMFA"
    effect = "Deny"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken"
    ]
    resources = [
      "*"
    ]      
    condition {
      test = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values = [
	"false"
      ]	
    }
  }
}  

resource "aws_iam_policy" "grant_self_service_auth_with_mfa" {
  name = "GrantSelfServiceAuthWithMFA"
  path = "/"
  description = "Allows users to manage all aspect of their account's authentication credentials. Account usage is diabled without MFA device."
  policy = data.aws_iam_policy_document.grant_self_service_auth_with_mfa.json
}
