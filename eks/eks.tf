data "aws_iam_role" "cluster_account_role" {
  provider = aws.cluster

  name = var.cluster_account_assume_role_name
}

data "aws_iam_policy_document" "grant_eks_create_cluster_envelope_encryption_key_access" {
  provider = aws.cluster
  count    = var.cluster_count

  statement {
    actions = [
      "kms:DescribeKey",
      "kms:CreateGrant"
    ]
    resources = [aws_kms_key.envelope_encryption[count.index].arn]
  }
}

resource "aws_iam_policy" "grant_eks_create_cluster_envelope_encryption_key_access" {
  provider = aws.cluster
  count    = var.cluster_count

  name        = "GrantEKSCreateClusterEnvelopeEncryptionKeyAccess_${local.cluster_names[count.index]}"
  description = "Used during Terraform setup of the EKS cluster to create grants on keys used for envelope encryption"
  policy      = data.aws_iam_policy_document.grant_eks_create_cluster_envelope_encryption_key_access[count.index].json

  tags = {
    Name        = "GrantEKSCreateClusterEnvelopeEncryptionKeyAccess_${local.cluster_names[count.index]}"
    Description = "Used during Terraform setup of the EKS cluster to create grants on keys used for envelope encryption"
    Cluster     = local.cluster_names[count.index]
  }
}

resource "aws_iam_role_policy_attachment" "grant_eks_create_cluster_envelope_encryption_key_access_to_cluster_account_role" {
  provider = aws.cluster
  count    = var.cluster_count

  role       = data.aws_iam_role.cluster_account_role.name
  policy_arn = aws_iam_policy.grant_eks_create_cluster_envelope_encryption_key_access[count.index].arn
}
