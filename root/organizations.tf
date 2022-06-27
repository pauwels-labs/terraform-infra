# Organizational structure derived from:
# https://aws.amazon.com/blogs/mt/best-practices-for-organizational-units-with-aws-organizations/

# Create root Pauwels Labs organization
resource "aws_organizations_organization" "pauwelslabs" {
  enabled_policy_types = [
    "AISERVICES_OPT_OUT_POLICY",
  ]
  feature_set = "ALL"
}


resource "aws_iam_account_alias" "pauwels_labs" {
  account_alias = "pauwels-labs"
}

# Opt out of all AWS AI services
resource "aws_organizations_policy" "all_ai_opt_out" {
  name = "Opt-out of all AWS AI services"
  description = "Blocks AWS AI services from accessing any accounts under this policy, and any child policies from overriding this policy"
  type = "AISERVICES_OPT_OUT_POLICY"  
  content = <<CONTENT
{
    "services": {
        "@@operators_allowed_for_child_policies": ["@@none"],
        "default": {
            "@@operators_allowed_for_child_policies": ["@@none"],
            "opt_out_policy": {
                "@@operators_allowed_for_child_policies": ["@@none"],
                "@@assign": "optOut"
            }
        }
    }
}
CONTENT
}

resource "aws_organizations_policy_attachment" "root_all_ai_opt_out" {
  target_id = aws_organizations_organization.pauwelslabs.roots[0].id
  policy_id = aws_organizations_policy.all_ai_opt_out.id
}

# Accounts pending deletion
resource "aws_organizations_organizational_unit" "suspended" {
  name      = "Suspended"
  parent_id = aws_organizations_organization.pauwelslabs.roots[0].id
}

# Individual accounts for users that want to explore AWS
resource "aws_organizations_organizational_unit" "sandbox" {
  name      = "Sandbox"
  parent_id = aws_organizations_organization.pauwelslabs.roots[0].id
}

# Shared global infrastructure, divided into software-development
# lifecycle (SDLC) and production OUs
resource "aws_organizations_organizational_unit" "infrastructure" {
  name = "Infrastructure"
  parent_id = aws_organizations_organization.pauwelslabs.roots[0].id  
}

# Production global infrastructure
resource "aws_organizations_organizational_unit" "infrastructure_prod" {
  name = "Prod"
  parent_id = aws_organizations_organizational_unit.infrastructure.id  
}

# Non-production global infrastructure
resource "aws_organizations_organizational_unit" "infrastructure_sdlc" {
  name = "SDLC"
  parent_id = aws_organizations_organizational_unit.infrastructure.id  
}

# All non-prod DNS services
# Non-prod accounts in other organizational units should NOT depend on
# the DNS services in this account. This account is strictly for networking
# teams testing modifications in a sandbox.
# Disabled until we really need it
# resource "aws_organizations_account" "dns_dev" {
#   name  = "DNS Dev"
#   email = "alex+dns-dev@pauwelslabs.com"
#   parent_id = aws_organizations_organizational_unit.infrastructure_sdlc.id
#   iam_user_access_to_billing = "ALLOW"  
# }

# Pauwels Labs' primary DNS services account
resource "aws_organizations_account" "dns_prod" {
  name  = "DNS Prod"
  email = "alex+dns-prod@pauwelslabs.com"
  parent_id = aws_organizations_organizational_unit.infrastructure_prod.id
  iam_user_access_to_billing = "ALLOW"  
}

# Pauwels Labs' primary artifacts account (container registry, package registries, etc)
resource "aws_organizations_account" "artifacts_prod" {
  name  = "Artifacts Prod"
  email = "alex+artifacts-prod@pauwelslabs.com"
  parent_id = aws_organizations_organizational_unit.infrastructure_prod.id
  iam_user_access_to_billing = "ALLOW"  
}

# Pauwels Labs' primary key account (all AWS KMS keys should be here)
resource "aws_organizations_account" "keys_prod" {
  name  = "Keys Prod"
  email = "alex+keys-prod@pauwelslabs.com"
  parent_id = aws_organizations_organizational_unit.infrastructure_prod.id
  iam_user_access_to_billing = "ALLOW"  
}

# Service workloads, divided into software-development lifecycle (SDLC)
# and production OUs
resource "aws_organizations_organizational_unit" "workloads" {
  name      = "Workloads"
  parent_id = aws_organizations_organization.pauwelslabs.roots[0].id
}

# Production service workloads
resource "aws_organizations_organizational_unit" "workloads_prod" {
  name      = "Prod"
  parent_id = aws_organizations_organizational_unit.workloads.id
}

# All non-production service workloads
resource "aws_organizations_organizational_unit" "workloads_sdlc" {
  name      = "SDLC"
  parent_id = aws_organizations_organizational_unit.workloads.id
}

# All non-prod workloads for engineering
resource "aws_organizations_account" "engineering_dev" {
  name  = "Engineering Dev"
  email = "alex+engineering-dev@pauwelslabs.com"
  parent_id = aws_organizations_organizational_unit.workloads_sdlc.id
  iam_user_access_to_billing = "ALLOW"
}

# Hosts deployment services (e.g. CICD pipelines), divided into
# software-development lifecycle (SDLC) and production OUs
resource "aws_organizations_organizational_unit" "deployments" {
  name      = "Deployments"
  parent_id = aws_organizations_organization.pauwelslabs.roots[0].id
}

# Production service workloads
resource "aws_organizations_organizational_unit" "deployments_prod" {
  name      = "Prod"
  parent_id = aws_organizations_organizational_unit.deployments.id
}

# All non-production service deployments
resource "aws_organizations_organizational_unit" "deployments_sdlc" {
  name      = "SDLC"
  parent_id = aws_organizations_organizational_unit.deployments.id
}

# All non-prod workloads for engineering
resource "aws_organizations_account" "engineering_deployments_prod" {
  name  = "Engineering Deployments Prod"
  email = "alex+engineering-deployments-prod@pauwelslabs.com"
  parent_id = aws_organizations_organizational_unit.deployments_prod.id
  iam_user_access_to_billing = "ALLOW"
}
