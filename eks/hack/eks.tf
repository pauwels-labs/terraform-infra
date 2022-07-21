terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }
  }
}

provider "kubernetes" {
  alias                  = "c0"
  host                   = module.c0[0].cluster_endpoint
  cluster_ca_certificate = base64decode(module.c0[0].cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.c0[0].cluster_id, "--region", var.cluster_region, "--profile", "mfa", "--role-arn", var.cluster_account_role_arn]
  }
}

module "c0" {
  source    = "terraform-aws-modules/eks/aws"
  version   = "18.26.3"
  count     = 1 <= var.cluster_count ? 1 : 0
  providers = {
    kubernetes = kubernetes.c0
  }

  cluster_name                    = "${var.cluster_name}-0"
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_tags                    = {
    Name        = "${var.cluster_name}-0"
    Description = var.cluster_description
  }

  cluster_ip_family         = var.cluster_ip_family
  cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr

  cluster_addons = var.cluster_addons

  cluster_encryption_config = [
    {
      provider_key_arn = var.encryption_keys[0].arn
      resources        = [
        "secrets"
      ]
    }
  ]

  vpc_id     = var.vpc_id
  subnet_ids = [for subnet in slice(var.subnets, 0, var.az_count): subnet.id]

  manage_aws_auth_configmap = var.manage_aws_auth_configmap

  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults

  eks_managed_node_groups = {
    for subnet in slice(var.subnets, 0, var.az_count) : subnet.availability_zone => {
      name        = "${var.cluster_name}-0-${subnet.availability_zone}"
      description = "EKS node group in a private subnet for the ${var.cluster_name}-0 cluster scoped to the ${subnet.availability_zone} AZ"

      subnet_ids = [subnet.id]
      disk_size  = var.disk_size

      min_size = var.min_size
      max_size = var.max_size
    }
  }
}
