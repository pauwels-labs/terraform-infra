provider "kubernetes" {
  alias                  = "c6"
  host                   = local.cluster_create[local.cluster_index[6]] ? local.cluster_endpoints[local.cluster_index[6]] : ""
  cluster_ca_certificate = base64decode(local.cluster_create[local.cluster_index[6]] ? local.cluster_ca_datas[local.cluster_index[6]] : "")
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", local.cluster_create[local.cluster_index[6]] ? local.cluster_names[local.cluster_index[6]] : "", "--region", local.cluster_region, "--profile", "mfa", "--role-arn", local.cluster_account_role_arn]
  }
}

resource "kubernetes_namespace" "flux_system_c6" {
  provider = kubernetes.c6
  count    = local.cluster_create[local.cluster_index[6]] ? 1 : 0

  metadata {
    name = "flux-system"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels
    ]
  }
}

resource "kubernetes_manifest" "flux_install_content_c6" {
  provider = kubernetes.c6
  for_each = local.cluster_create[local.cluster_index[6]] ? {
    for i, v in data.kubectl_file_documents.install_content[local.cluster_index[6]].documents : i => v if yamldecode(v).kind != "Namespace"
  } : {}

  manifest = {
    for k, v in yamldecode(each.value) : k => v if k != "status"
  }
  computed_fields = [
    "metadata",
    "spec.template.spec.containers"
  ]

  depends_on = [
    kubernetes_namespace.flux_system_c6
  ]
}

resource "kubernetes_manifest" "flux_sync_content_c6" {
  provider = kubernetes.c6
  for_each = local.cluster_create[local.cluster_index[6]] ? {
    for i, v in data.kubectl_file_documents.sync_content[local.cluster_index[6]].documents : i => v if yamldecode(v).kind != "Namespace"
  } : {}

  manifest = {
    for k, v in yamldecode(each.value) : k => v if k != "status"
  }
  computed_fields = [
    "metadata",
    "spec.template.spec.containers"
  ]

  depends_on = [
    kubernetes_namespace.flux_system_c6,
    kubernetes_manifest.flux_install_content_c6
  ]
}

resource "kubernetes_secret" "flux_infra_deploy_key_c6" {
  provider = kubernetes.c6
  count    = local.cluster_create[local.cluster_index[6]] ? 1 : 0

  depends_on = [kubernetes_manifest.flux_install_content_c6]

  metadata {
    name      = data.flux_sync.this[count.index].secret
    namespace = data.flux_sync.this[count.index].namespace
  }

  data = {
    identity       = tls_private_key.flux_infra_deploy_key[local.cluster_index[6]].private_key_pem
    "identity.pub" = tls_private_key.flux_infra_deploy_key[local.cluster_index[6]].public_key_pem
    known_hosts    = local.known_hosts
  }
}
