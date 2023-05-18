provider "aws" {
  region = "eu-west-1"
  profile = "mfa"  
  assume_role {
    role_arn = "arn:aws:iam::274295908850:role/OrganizationAccountAccessRole"
  }  
}

resource "aws_ecr_repository" "pauwels_labs_redact_store" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/redact-store"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_store_cache" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/redact-store/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_data" {
  name                 = "pauwels-labs/redact-data"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}


resource "aws_ecr_repository" "pauwels_labs_redact_data_cache" {
  name                 = "pauwels-labs/redact-data/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_homepage" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/homepage"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "pauwels_labs_homepage_cache" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/homepage/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_website" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/redact-website"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_website_cache" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/redact-website/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_client" {
  name                 = "pauwels-labs/redact-client"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_client_cache" {
  name                 = "pauwels-labs/redact-client/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_crypto_cache" {
  name                 = "pauwels-labs/redact-crypto/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_toml_editor" {
  name                 = "pauwels-labs/toml-editor"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_toml_editor_cache" {
  name                 = "pauwels-labs/toml-editor/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_feed_ui" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/redact-feed-ui"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_feed_ui_cache" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/redact-feed-ui/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_feed_api" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/redact-feed-api"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_feed_api_cache" {
  name                 = "t/pauwels-labs-main/github/pauwels-labs/redact-feed-api/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    TenantName = "pauwels-labs-main"
  }
}

resource "aws_ecr_repository" "amazon_lb_controller" {
  name                 = "amazon/aws-load-balancer-controller"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "amazon_lb_controller_helm" {
  name                 = "helm/amazon/aws-load-balancer-controller"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "cert_manager_controller" {
  name                 = "jetstack/cert-manager-controller"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "cert_manager_webhook" {
  name                 = "jetstack/cert-manager-webhook"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "cert_manager_cainjector" {
  name                 = "jetstack/cert-manager-cainjector"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "cert_manager_ctl" {
  name                 = "jetstack/cert-manager-ctl"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "cert_manager_helm" {
  name                 = "helm/jetstack/cert-manager"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "istio_base_helm" {
  name                 = "helm/istio/base"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "istio_istiod_helm" {
  name                 = "helm/istio/istiod"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "istio_gateway_helm" {
  name                 = "helm/istio/gateway"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "istio_pilot" {
  name                 = "istio/pilot"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "istio_proxyv2" {
  name                 = "istio/proxyv2"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "kiali" {
  name                 = "i/kiali/kiali"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "kiali_operator" {
  name                 = "i/kiali/kiali-operator"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "kiali_operator_helm" {
  name                 = "helm/kiali/kiali-operator"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "fluxcd_flux_cli" {
  name                 = "fluxcd/flux-cli"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "fluxcd_helm_controller" {
  name                 = "fluxcd/helm-controller"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "fluxcd_kustomize_controller" {
  name                 = "fluxcd/kustomize-controller"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "fluxcd_notification_controller" {
  name                 = "fluxcd/notification-controller"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "fluxcd_source_controller" {
  name                 = "fluxcd/source-controller"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "amazon_aws_cli" {
  name                 = "amazon/aws-cli"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "external_dns" {
  name                 = "external-dns/external-dns"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "external_dns_helm" {
  name                 = "helm/external-dns/external-dns"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "vault_k8s" {
  name                 = "hashicorp/vault-k8s"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "vault" {
  name                 = "hashicorp/vault"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "vault_csi_provider" {
  name                 = "hashicorp/vault-csi-provider"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "vault_helm" {
  name                 = "helm/hashicorp/vault"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "ebs_csi_driver" {
  name                 = "amazon/aws-ebs-csi-driver"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "csi_provisioner" {
  name                 = "sig-storage/csi-provisioner"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "csi_attacher" {
  name                 = "sig-storage/csi-attacher"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "csi_snapshotter" {
  name                 = "sig-storage/csi-snapshotter"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "csi_livenessprobe" {
  name                 = "sig-storage/livenessprobe"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "csi_resizer" {
  name                 = "sig-storage/csi-resizer"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "csi_node_driver_registrar" {
  name                 = "sig-storage/csi-node-driver-registrar"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "ebs_csi_driver_helm" {
  name                 = "helm/amazon/aws-ebs-csi-driver"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "weave_gitops" {
  name                 = "i/weaveworks/wego-app"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "weave_gitops_helm" {
  name                 = "helm/weaveworks/weave-gitops"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "keycloak" {
  name                 = "keycloak/keycloak"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "keycloak_operator" {
  name                 = "keycloak/keycloak-operator"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "keycloak_operator_helm" {
  name                 = "helm/keycloak/keycloak-operator"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "oauth2_proxy" {
  name                 = "oauth2-proxy/oauth2-proxy"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "oauth2_proxy_helm" {
  name                 = "helm/oauth2-proxy/oauth2-proxy"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "secrets_store_csi_driver" {
  name                 = "kubernetes-sigs/secrets-store-csi-driver"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "external_secrets" {
  name                 = "external-secrets/external-secrets"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "external_secrets_helm" {
  name                 = "helm/external-secrets/external-secrets"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "alertmanager" {
  name                 = "prometheus/alertmanager"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "blackbox_exporter" {
  name                 = "prometheus/blackbox-exporter"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "grafana" {
  name                 = "i/grafana/grafana"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "kiwigrid_k8s_sidecar" {
  name                 = "i/kiwigrid/k8s-sidecar"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "grafana_helm" {
  name                 = "helm/grafana/grafana"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "kube_state_metrics" {
  name                 = "kube-state-metrics/kube-state-metrics"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "node_exporter" {
  name                 = "prometheus/node-exporter"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "prometheus" {
  name                 = "prometheus/prometheus"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "prometheus_adapter" {
  name                 = "prometheus-adapter/prometheus-adapter"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "prometheus_operator" {
  name                 = "prometheus-operator/prometheus-operator"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "prometheus_config_reloader" {
  name                 = "prometheus-operator/prometheus-config-reloader"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "kube_rbac_proxy" {
  name                 = "brancz/kube-rbac-proxy"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "configmap_reload" {
  name                 = "i/jimmidyson/configmap-reload"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "tektoncd_controller" {
  name                 = "tektoncd/controller"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "tektoncd_webhook" {
  name                 = "tektoncd/webhook"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "tektoncd_dashboard" {
  name                 = "i/tektoncd/dashboard"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "amazon_aws_cli_with_jq" {
  name                 = "amazon/aws-cli-with-jq"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "semantic_release" {
  name                 = "i/semantic-release/semantic-release"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "change" {
  name                 = "i/change/change"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "node" {
  name                 = "i/node/node"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "opentelemetry_collector" {
  name                 = "i/otel/opentelemetry-collector"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "opentelemetry_collector_contrib" {
  name                 = "i/otel/opentelemetry-collector-contrib"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "opentelemetry_collector_helm" {
  name                 = "helm/open-telemetry/opentelemetry-collector"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "jaeger_operator" {
  name                 = "i/jaeger/operator"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "grafana_agent_helm" {
  name                 = "helm/grafana/grafana-agent"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "grafana_mimir" {
  name                 = "i/grafana/mimir"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "grafana_mimir_distributed_helm" {
  name                 = "helm/grafana/mimir-distributed"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "grafana_agent" {
  name                 = "i/grafana/agent"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "grafana_agent_operator" {
  name                 = "i/grafana/agent-operator"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "grafana_agent_operator_helm" {
  name                 = "helm/grafana/grafana-agent-operator"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "grafana_mimir_continuous_test" {
  name                 = "i/grafana/mimir-continuous-test"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "cortex_tenant" {
  name                 = "i/cortex/tenant"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "cluster_autoscaler" {
  name                 = "i/k8s/autoscaling/cluster-autoscaler"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "rust" {
  name                 = "i/rust"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}
