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

  name        = "GrantEKSCreateClusterEnvelopeEncryptionKeyAccess,${var.cluster_name}-${count.index}"
  description = "Used during Terraform setup of the EKS cluster to create grants on keys used for envelope encryption"
  policy      = data.aws_iam_policy_document.grant_eks_create_cluster_envelope_encryption_key_access[count.index].json
}

resource "aws_iam_role_policy_attachment" "grant_eks_create_cluster_envelope_encryption_key_access_to_cluster_account_role" {
  provider = aws.cluster
  count    = var.cluster_count

  role       = data.aws_iam_role.cluster_account_role.name
  policy_arn = aws_iam_policy.grant_eks_create_cluster_envelope_encryption_key_access[count.index].arn
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.24.1"
  providers = {
    aws = aws.cluster
  }

  cluster_name                    = "${var.cluster_name}-${count.index}"
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false
  cluster_tags                    = {
    Name = "${var.cluster_name}-${count.index}"
  }

  cluster_ip_family = "ipv4"

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube_proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.envelope_encryption[count.index].arn
      resources        = [
        "secrets"
      ]
    }
  ]

  vpc_id     = aws_vpc.cluster.id
  subnet_ids = [for s in slice(aws_subnet.cluster, count.index * local.az_count, count.index * local.az_count + local.az_count): s.id]

  manage_aws_auth_configmap = true
}
