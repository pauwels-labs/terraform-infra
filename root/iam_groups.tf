# Group for all users with access to Infrastructure/Prod/Artifacts Prod/OrganizationAccountAccessRole
resource "aws_iam_group" "infrastructure_prod_artifacts_prod_administrators" {
  name = "InfrastructureProdArtifactsProdAdministrators"
}

resource "aws_iam_group_policy_attachment" "infrastructure_prod_artifacts_prod_administrator_role" {
  group = aws_iam_group.infrastructure_prod_artifacts_prod_administrators.name
  policy_arn = aws_iam_policy.grant_infrastructure_prod_artifacts_prod_administrator_role.arn
}

# Group for Terraform accessing its S3 backend
resource "aws_iam_group" "terraform_backend" {
  name = "TerraformBackend"
}

resource "aws_iam_group_policy_attachment" "terraform_backend_role" {
  group = aws_iam_group.terraform_backend.name
  policy_arn = aws_iam_policy.grant_terraform_backend_role.arn
}

# Group for all users with access to Workloads/SDLC/Engineering Dev/OrganizationAccountAccessRole
resource "aws_iam_group" "workloads_sdlc_engineering_dev_administrators" {
  name = "WorkloadsSDLCEngineeringDevAdministrators"
}

resource "aws_iam_group_policy_attachment" "workloads_sdlc_engineering_dev_administrator_role" {
  group = aws_iam_group.workloads_sdlc_engineering_dev_administrators.name
  policy_arn = aws_iam_policy.grant_workloads_sdlc_engineering_dev_administrator_role.arn
}

# Group for all users with access to Deployments/Prod/Engineering Deployments Prod/OrganizationAccountAccessRole
resource "aws_iam_group" "deployments_prod_engineering_deployments_prod_administrators" {
  name = "DeploymentsProdEngineeringDeploymentsProdAdministrators"
}

resource "aws_iam_group_policy_attachment" "deployments_prod_engineering_deployments_prod_administrator_role" {
  group = aws_iam_group.deployments_prod_engineering_deployments_prod_administrators.name
  policy_arn = aws_iam_policy.grant_deployments_prod_engineering_deployments_prod_administrator_role.arn
}

# Group for all users with access to Infrastructure/Prod/DNS Prod/OrganizationAccountAccessRole
resource "aws_iam_group" "infrastructure_prod_dns_prod_administrators" {
  name = "InfrastructureProdDNSProdAdministrators"
}

resource "aws_iam_group_policy_attachment" "infrastructure_prod_dns_prod_administrator_role" {
  group = aws_iam_group.infrastructure_prod_dns_prod_administrators.name
  policy_arn = aws_iam_policy.grant_infrastructure_prod_dns_prod_administrator_role.arn
}

# Group for all users with access to Infrastructure/Prod/Keys Prod/OrganizationAccountAccessRole
resource "aws_iam_group" "infrastructure_prod_keys_prod_administrators" {
  name = "InfrastructureProdKeysProdAdministrators"
}

resource "aws_iam_group_policy_attachment" "infrastructure_prod_keys_prod_administrator_role" {
  group = aws_iam_group.infrastructure_prod_keys_prod_administrators.name
  policy_arn = aws_iam_policy.grant_infrastructure_prod_keys_prod_administrator_role.arn
}

# Group for all users with access to Infrastructure/Prod/VPN Prod/OrganizationAccountAccessRole
resource "aws_iam_group" "infrastructure_prod_vpn_prod_administrators" {
  name = "InfrastructureProdVPNProdAdministrators"
}

resource "aws_iam_group_policy_attachment" "infrastructure_prod_vpn_prod_administrator_role" {
  group = aws_iam_group.infrastructure_prod_vpn_prod_administrators.name
  policy_arn = aws_iam_policy.grant_infrastructure_prod_vpn_prod_administrator_role.arn
}

# Group for all root account administrators
resource "aws_iam_group" "root_administrators" {
  name = "RootAdministrators"
}

resource "aws_iam_group_policy_attachment" "root_administrator_role" {
  group = aws_iam_group.root_administrators.name
  policy_arn = aws_iam_policy.grant_root_administrator_role.arn
}

# All new users that have not yet signed in should be in this group and this group ONLY.
# The only permissions given to such a user is the ability to change its own password.
# After the user has logged in and changed its password, the user's group membership
# should be removed and be placed in the SelfServiceAuthMFA group, and the NewUsers
# group MUST be removed. This is because the NewUsers group allows for password changing
# with MFA disabled, which should only be allowed during the initial bootstrapping of the user.
resource "aws_iam_group" "new_users" {
  name = "NewUsers"
}

resource "aws_iam_group_policy_attachment" "new_users_change_password" {
  group      = aws_iam_group.new_users.name
  policy_arn = aws_iam_policy.iam_user_change_password.arn
}

resource "aws_iam_group" "self_service_auth_with_mfa" {
  name = "SelfServiceAuthWithMFA"  
}

resource "aws_iam_group_policy_attachment" "self_service_auth_with_mfa" {
  group      = aws_iam_group.self_service_auth_with_mfa.name
  policy_arn = aws_iam_policy.grant_self_service_auth_with_mfa.arn
}
