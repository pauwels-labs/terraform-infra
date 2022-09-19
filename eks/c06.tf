provider "kubernetes" {
  alias                  = "c6"
  host                   = local.cluster_create[local.cluster_index[6]] ? module.c6[0].cluster_endpoint : ""
  cluster_ca_certificate = base64decode(local.cluster_create[local.cluster_index[6]] ? module.c6[0].cluster_certificate_authority_data : "")
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", local.cluster_create[local.cluster_index[6]] ? module.c6[0].cluster_id : "", "--region", var.cluster_region, "--profile", "mfa", "--role-arn", local.cluster_account_role_arn]
  }
}

module "c6" {
  source    = "terraform-aws-modules/eks/aws"
  version   = "18.26.3"
  count     = local.cluster_create[local.cluster_index[6]] ? 1 : 0
  providers = {
    aws        = aws.cluster
    kubernetes = kubernetes.c6
  }

  cluster_name                    = local.cluster_names[local.cluster_index[6]]
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_tags                    = {
    Name        = local.cluster_names[local.cluster_index[6]]
    Description = var.cluster_description
  }

  cluster_ip_family          = var.use_ipv6 ? "ipv6" : "ipv4"
  create_cni_ipv6_iam_policy = var.use_ipv6
  cluster_service_ipv4_cidr  = var.use_ipv6 ? null : var.cluster_service_cidr

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  iam_role_name            = local.cluster_iam_role_name[local.cluster_index[6]]
  iam_role_use_name_prefix = false

  cluster_encryption_policy_name            = local.cluster_encryption_policy_name[local.cluster_index[6]]
  cluster_encryption_policy_use_name_prefix = false
  cluster_encryption_config                 = [
    {
      provider_key_arn = aws_kms_key.envelope_encryption[local.cluster_index[6]].arn
      resources        = [
        "secrets"
      ]
    }
  ]

  vpc_id     = aws_vpc.cluster.id
  subnet_ids = [for subnet in slice(aws_subnet.private, local.cluster_index[6] * local.az_count, local.cluster_index[6] * local.az_count + local.az_count): subnet.id]

  node_security_group_additional_rules = {
    allow_all_outbound_ssh = {
      description      = "Egress all SSH to internet"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      type             = "egress"
      ipv6_cidr_blocks = ["::/0"]
    }

    allow_istio_webhook = {
      description                   = "Cluster API to Istio webhook"
      from_port                     = 15017
      to_port                       = 15017
      protocol                      = "tcp"
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }

  manage_aws_auth_configmap = true

  eks_managed_node_group_defaults = {
    ami_type       = "BOTTLEROCKET_x86_64"
    platform       = "bottlerocket"
    capacity_type  = "SPOT"
    instance_types = var.cluster_instance_types
  }

  eks_managed_node_groups = {
    for subnet in slice(aws_subnet.private, local.cluster_index[6] * local.az_count, local.cluster_index[6] * local.az_count + local.az_count) : subnet.availability_zone => {
      name        = "${local.cluster_names[local.cluster_index[6]]}-${subnet.availability_zone}"
      description = "EKS node group in a private subnet for the ${local.cluster_names[local.cluster_index[6]]} cluster scoped to the ${subnet.availability_zone} AZ"

      subnet_ids = [subnet.id]
      disk_size  = var.instance_disk_size

      min_size = var.node_group_min_size
      max_size = var.node_group_max_size
    }
  }
}
