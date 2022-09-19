data aws_iam_policy_document "pauwels_labs_ecr_policy" {
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
