provider "kubernetes" {
  alias                  = "c4"
  host                   = local.c4_create ? module.c4[0].cluster_endpoint : ""
  cluster_ca_certificate = base64decode(local.c4_create ? module.c4[0].cluster_certificate_authority_data : "")
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", local.c4_create ? module.c4[0].cluster_id : "", "--region", var.cluster_region, "--profile", "mfa", "--role-arn", local.cluster_account_role_arn]
  }
}

module "c4" {
  source    = "terraform-aws-modules/eks/aws"
  version   = "18.26.3"
  count     = local.c4_create ? 1 : 0
  providers = {
    aws        = aws.cluster
    kubernetes = kubernetes.c4
  }

  cluster_name                    = "${var.cluster_name}-${local.c4}"
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_tags                    = {
    Name        = "${var.cluster_name}-${local.c4}"
    Description = var.cluster_description
  }

  cluster_ip_family         = "ipv4"
  cluster_service_ipv4_cidr = var.cluster_service_cidr

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.envelope_encryption[local.c4].arn
      resources        = [
        "secrets"
      ]
    }
  ]

  vpc_id     = aws_vpc.cluster.id
  subnet_ids = [for subnet in slice(aws_subnet.private, local.c4 * local.az_count, local.c4 * local.az_count + local.az_count): subnet.id]

  manage_aws_auth_configmap = true

  eks_managed_node_group_defaults = {
    ami_type       = "BOTTLEROCKET_x86_64"
    platform       = "bottlerocket"
    capacity_type  = "SPOT"
    instance_types = var.cluster_instance_types
  }

  eks_managed_node_groups = {
    for subnet in slice(aws_subnet.private, local.c4 * local.az_count, local.c4 * local.az_count + local.az_count) : subnet.availability_zone => {
      name        = "${var.cluster_name}-${local.c4}-${subnet.availability_zone}"
      description = "EKS node group in a private subnet for the ${var.cluster_name}-${local.c4} cluster scoped to the ${subnet.availability_zone} AZ"

      subnet_ids = [subnet.id]
      disk_size  = var.instance_disk_size

      min_size = var.node_group_min_size
      max_size = var.node_group_max_size
    }
  }
}
