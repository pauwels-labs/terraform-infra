resource "aws_iam_openid_connect_provider" "oidc_provider" {
  provider = aws.ecr

  url             = "https://${var.oidc_url}"
  thumbprint_list = var.oidc_thumbprint
  client_id_list  = var.audiences.aud
}

data aws_iam_policy_document "allow_tenant_ro_access_to_ecr_namespace" {
  statement {
    sid = "AllowTenantROAccessToECRNamespace"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
    resources = [
      "${local.ecr_arn}/*"
    ]
    condition {
      test     = "Null"
      variable = "ecr:ResourceTag/TenantName"
      values   = [
        "false"
      ]
    }
    condition {
      test     = "Null"
      variable = "identity.pauwelslabs.com/realms/pauwels-labs-main:sub"
      values   = [
        "false"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "identity.pauwelslabs.com/realms/pauwels-labs-main:sub"
      values   = [
        "[*$${ecr:ResourceTag/TenantName}*]"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "ecr:ResourceTag/TenantName"
      values   = [
        "?*"
      ]
    }
  }
  statement {
    sid = "AllowTenantROAccessToInfraNamespace"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
    resources = [
      "${local.ecr_arn}/i/*"
    ]
  }
  statement {
    sid = "AllowAuthTokenGeneration"    
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = [
      "*"
    ]
  }
}

data aws_iam_policy_document "allow_tenant_rw_access_to_ecr_namespace" {
  statement {
    sid = "AllowTenantRWAccessToECRNamespace"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:ListImages"
    ]
    resources = [
      "${local.ecr_arn}/*"
    ]
    condition {
      test     = "Null"
      variable = "ecr:ResourceTag/TenantName"
      values   = [
        "false"
      ]
    }
    condition {
      test     = "Null"
      variable = "identity.pauwelslabs.com/realms/pauwels-labs-main:sub"
      values   = [
        "false"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "identity.pauwelslabs.com/realms/pauwels-labs-main:sub"
      values   = [
        "[$${ecr:ResourceTag/TenantName}*]"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "ecr:ResourceTag/TenantName"
      values   = [
        "?*"
      ]
    }
  }
  statement {
    sid = "AllowTenantROAccessToInfraNamespace"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
    resources = [
      "${local.ecr_arn}/i/*"
    ]
  }
  statement {
    sid = "AllowAuthTokenGeneration"    
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "allow_tenant_ro_access_to_ecr_namespace" {
  provider = aws.ecr

  name = "AllowTenantROAccessToECRNamespace"
  path = "/"
  description = "Allows RO access to pauwels-labs ECR registry in the specified tenant namespace, i.e. /t/<tenant name>"
  
  policy = data.aws_iam_policy_document.allow_tenant_ro_access_to_ecr_namespace.json
}

resource "aws_iam_policy" "allow_tenant_rw_access_to_ecr_namespace" {
  provider = aws.ecr

  name = "AllowTenantRWAccessToECRNamespace"
  path = "/"
  description = "Allows RW access to pauwels-labs ECR registry in the specified tenant namespace, i.e. /t/<tenant name>"

  policy = data.aws_iam_policy_document.allow_tenant_rw_access_to_ecr_namespace.json
}

data "aws_iam_policy_document" "allow_oidc_trust_relationship_admins_writers" {
  statement {
    actions   = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    effect    = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.oidc_provider.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.oidc_url}:aud"
      values   = var.audiences.azp
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_url}:oaud"
      values   = var.audiences.aud
    }
    condition {
      test     = "StringLike"
      variable = "${var.oidc_url}:sub"
      values   = [
        "*$${sts:RoleSessionName}*"
      ]
    }
    condition {
      test     = "ForAnyValue:StringLike"
      variable = "${var.oidc_url}:amr"
      values   = [
        "/tenant-$${sts:RoleSessionName}/root/admins",
        "/tenant-$${sts:RoleSessionName}/root/writers",
        "/tenant-$${sts:RoleSessionName}/ecr/admins",
        "/tenant-$${sts:RoleSessionName}/ecr/writers"
      ]
    }
  }
}

data "aws_iam_policy_document" "allow_oidc_trust_relationship_readers" {
  statement {
    actions   = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    effect    = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.oidc_provider.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.oidc_url}:aud"
      values   = [
        "aws"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_url}:oaud"
      values   = [
        "aws"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "${var.oidc_url}:sub"
      values   = [
        "*$${sts:RoleSessionName}*"
      ]
    }
    condition {
      test     = "ForAnyValue:StringLike"
      variable = "${var.oidc_url}:amr"
      values   = [
        "/tenant-$${sts:RoleSessionName}/root/readers",
        "/tenant-$${sts:RoleSessionName}/ecr/readers"
      ]
    }
  }
}

resource "aws_iam_role" "tenant_ecr_ro" {
  provider = aws.ecr

  name = "tenant-ecr-ro"

  assume_role_policy = data.aws_iam_policy_document.allow_oidc_trust_relationship_readers.json

  tags = {
    Name        = "tenant-ecr-ro"
    Description = "Role assumed by tenants to gain read-only access to their authorized ECR namespaces"
  }
}

resource "aws_iam_role" "tenant_ecr_rw" {
  provider = aws.ecr

  name = "tenant-ecr-rw"

  assume_role_policy = data.aws_iam_policy_document.allow_oidc_trust_relationship_admins_writers.json

  tags = {
    Name        = "tenant-ecr-rw"
    Description = "Role assumed by tenants to gain read-write access to their authorized ECR namespaces"
  }
}

resource "aws_iam_role_policy_attachment" "grant_ecr_access_to_tenant_ecr_ro" {
  provider = aws.ecr

  role       = aws_iam_role.tenant_ecr_ro.name
  policy_arn = aws_iam_policy.allow_tenant_ro_access_to_ecr_namespace.arn
}

resource "aws_iam_role_policy_attachment" "grant_ecr_access_to_tenant_ecr_rw" {
  provider = aws.ecr

  role       = aws_iam_role.tenant_ecr_rw.name
  policy_arn = aws_iam_policy.allow_tenant_rw_access_to_ecr_namespace.arn
}
