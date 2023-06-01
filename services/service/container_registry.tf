resource "aws_ecr_repository" "this" {
  name                 = "t/${local.full_tenant_name}/${var.repository_host}/${var.org_name}/${var.repository_name}"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = local.full_tenant_name
  }
}

resource "aws_ecr_repository" "this_cache" {
  name                 = "t/${local.full_tenant_name}/${var.repository_host}/${var.org_name}/${var.repository_name}/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = local.full_tenant_name
  }
}

resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy = data.aws_iam_policy_document.org_ecr_policy.json
}

resource "aws_ecr_repository_policy" "this_cache" {
  repository = aws_ecr_repository.this_cache.name
  policy = data.aws_iam_policy_document.org_ecr_policy.json
}

data aws_iam_policy_document "org_ecr_policy" {
  statement {
    sid     = "AllowWorkloadsSDLCEngineeringDevAccountsRWAccess"    
    effect  = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::601743579976:root"
      ]	
    }
  }

  statement {
    sid     = "AllowDeploymentsProdEngineeringDeploymentsProdAccountsRWAccess"    
    effect  = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken"
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::140327370353:root"
      ]	
    }
  }
}
