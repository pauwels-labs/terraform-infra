resource "aws_ecr_repository_policy" "pauwels_labs_redact_store" {
  repository = aws_ecr_repository.pauwels_labs_redact_store.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_store_cache" {
  repository = aws_ecr_repository.pauwels_labs_redact_store_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_homepage" {
  repository = aws_ecr_repository.pauwels_labs_homepage.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_homepage_cache" {
  repository = aws_ecr_repository.pauwels_labs_homepage_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_website" {
  repository = aws_ecr_repository.pauwels_labs_redact_website.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_website_cache" {
  repository = aws_ecr_repository.pauwels_labs_redact_website_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_client" {
  repository = aws_ecr_repository.pauwels_labs_redact_client.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_client_cache" {
  repository = aws_ecr_repository.pauwels_labs_redact_client_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_crypto_cache" {
  repository = aws_ecr_repository.pauwels_labs_redact_crypto_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_data" {
  repository = aws_ecr_repository.pauwels_labs_redact_data.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_data_cache" {
  repository = aws_ecr_repository.pauwels_labs_redact_data_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_toml_editor" {
  repository = aws_ecr_repository.pauwels_labs_toml_editor.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_toml_editor_cache" {
  repository = aws_ecr_repository.pauwels_labs_toml_editor_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_feed_ui" {
  repository = aws_ecr_repository.pauwels_labs_redact_feed_ui.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_feed_ui_cache" {
  repository = aws_ecr_repository.pauwels_labs_redact_feed_ui_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_feed_api" {
  repository = aws_ecr_repository.pauwels_labs_redact_feed_api.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_feed_api_cache" {
  repository = aws_ecr_repository.pauwels_labs_redact_feed_api_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_protonmail_bridge_docker" {
  repository = aws_ecr_repository.pauwels_labs_protonmail_bridge_docker.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_protonmail_bridge_docker_cache" {
  repository = aws_ecr_repository.pauwels_labs_protonmail_bridge_docker_cache.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "amazon_lb_controller" {
  repository = aws_ecr_repository.amazon_lb_controller.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "amazon_lb_controller_helm" {
  repository = aws_ecr_repository.amazon_lb_controller_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "cert_manager_controller" {
  repository = aws_ecr_repository.cert_manager_controller.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "cert_manager_webhook" {
  repository = aws_ecr_repository.cert_manager_webhook.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "cert_manager_cainjector" {
  repository = aws_ecr_repository.cert_manager_cainjector.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "cert_manager_ctl" {
  repository = aws_ecr_repository.cert_manager_ctl.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "cert_manager_helm" {
  repository = aws_ecr_repository.cert_manager_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "istio_base_helm" {
  repository = aws_ecr_repository.istio_base_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "istio_istiod_helm" {
  repository = aws_ecr_repository.istio_istiod_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "istio_gateway_helm" {
  repository = aws_ecr_repository.istio_gateway_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "istio_pilot" {
  repository = aws_ecr_repository.istio_pilot.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "istio_proxyc2" {
  repository = aws_ecr_repository.istio_proxyv2.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "kiali" {
  repository = aws_ecr_repository.kiali.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "kiali_operator" {
  repository = aws_ecr_repository.kiali_operator.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "kiali_operator_helm" {
  repository = aws_ecr_repository.kiali_operator_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "fluxcd_flux_cli" {
  repository = aws_ecr_repository.fluxcd_flux_cli.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "fluxcd_helm_controller" {
  repository = aws_ecr_repository.fluxcd_helm_controller.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "fluxcd_kustomize_controller" {
  repository = aws_ecr_repository.fluxcd_kustomize_controller.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "fluxcd_notification_controller" {
  repository = aws_ecr_repository.fluxcd_notification_controller.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "fluxcd_source_controller" {
  repository = aws_ecr_repository.fluxcd_source_controller.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "amazon_aws_cli" {
  repository = aws_ecr_repository.amazon_aws_cli.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "external_dns" {
  repository = aws_ecr_repository.external_dns.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "external_dns_helm" {
  repository = aws_ecr_repository.external_dns_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "vault_k8s" {
  repository = aws_ecr_repository.vault_k8s.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "vault" {
  repository = aws_ecr_repository.vault.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "vault_csi_provider" {
  repository = aws_ecr_repository.vault_csi_provider.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "vault_helm" {
  repository = aws_ecr_repository.vault_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "ebs_csi_driver" {
  repository = aws_ecr_repository.ebs_csi_driver.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "csi_provisioner" {
  repository = aws_ecr_repository.csi_provisioner.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "csi_attacher" {
  repository = aws_ecr_repository.csi_attacher.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "csi_snapshotter" {
  repository = aws_ecr_repository.csi_snapshotter.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "csi_livenessprobe" {
  repository = aws_ecr_repository.csi_livenessprobe.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "csi_resizer" {
  repository = aws_ecr_repository.csi_resizer.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "csi_node_driver_registrar" {
  repository = aws_ecr_repository.csi_node_driver_registrar.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "ebs_csi_driver_helm" {
  repository = aws_ecr_repository.ebs_csi_driver_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "weave_gitops" {
  repository = aws_ecr_repository.weave_gitops.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "weave_gitops_helm" {
  repository = aws_ecr_repository.weave_gitops_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "keycloak" {
  repository = aws_ecr_repository.keycloak.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "keycloak_operator" {
  repository = aws_ecr_repository.keycloak_operator.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "keycloak_operator_helm" {
  repository = aws_ecr_repository.keycloak_operator_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "oauth2_proxy" {
  repository = aws_ecr_repository.oauth2_proxy.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "oauth2_proxy_helm" {
  repository = aws_ecr_repository.oauth2_proxy_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "secrets_store_csi_driver" {
  repository = aws_ecr_repository.secrets_store_csi_driver.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "external_secrets" {
  repository = aws_ecr_repository.external_secrets.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "external_secrets_helm" {
  repository = aws_ecr_repository.external_secrets_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "alertmanager" {
  repository = aws_ecr_repository.alertmanager.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "blackbox_exporter" {
  repository = aws_ecr_repository.blackbox_exporter.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana" {
  repository = aws_ecr_repository.grafana.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "kiwigrid_k8s_sidecar" {
  repository = aws_ecr_repository.kiwigrid_k8s_sidecar.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_helm" {
  repository = aws_ecr_repository.grafana_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "kube_state_metrics" {
  repository = aws_ecr_repository.kube_state_metrics.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "node_exporter" {
  repository = aws_ecr_repository.node_exporter.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "prometheus" {
  repository = aws_ecr_repository.prometheus.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "prometheus_adapter" {
  repository = aws_ecr_repository.prometheus_adapter.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "prometheus_operator" {
  repository = aws_ecr_repository.prometheus_operator.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "prometheus_config_reloader" {
  repository = aws_ecr_repository.prometheus_config_reloader.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "kube_rbac_proxy" {
  repository = aws_ecr_repository.kube_rbac_proxy.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "configmap_reload" {
  repository = aws_ecr_repository.configmap_reload.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "tektoncd_controller" {
  repository = aws_ecr_repository.tektoncd_controller.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "tektoncd_webhook" {
  repository = aws_ecr_repository.tektoncd_webhook.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "tektoncd_dashboard" {
  repository = aws_ecr_repository.tektoncd_dashboard.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "amazon_aws_cli_with_jq" {
  repository = aws_ecr_repository.amazon_aws_cli_with_jq.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "semantic_release" {
  repository = aws_ecr_repository.semantic_release.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "change" {
  repository = aws_ecr_repository.change.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "node" {
  repository = aws_ecr_repository.node.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "opentelemetry_collector" {
  repository = aws_ecr_repository.opentelemetry_collector.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "opentelemetry_collector_contrib" {
  repository = aws_ecr_repository.opentelemetry_collector_contrib.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "opentelemetry_collector_helm" {
  repository = aws_ecr_repository.opentelemetry_collector_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "jaeger_operator" {
  repository = aws_ecr_repository.jaeger_operator.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_agent_helm" {
  repository = aws_ecr_repository.grafana_agent_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_mimir" {
  repository = aws_ecr_repository.grafana_mimir.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_mimir_distributed_helm" {
  repository = aws_ecr_repository.grafana_mimir_distributed_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_loki" {
  repository = aws_ecr_repository.grafana_loki.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_loki_canary" {
  repository = aws_ecr_repository.grafana_loki_canary.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_loki_helm" {
  repository = aws_ecr_repository.grafana_loki_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_agent" {
  repository = aws_ecr_repository.grafana_agent.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_agent_operator" {
  repository = aws_ecr_repository.grafana_agent_operator.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_agent_operator_helm" {
  repository = aws_ecr_repository.grafana_agent_operator_helm.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "grafana_mimir_continuous_test" {
  repository = aws_ecr_repository.grafana_mimir_continuous_test.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "cortex_tenant" {
  repository = aws_ecr_repository.cortex_tenant.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "cluster_autoscaler" {
  repository = aws_ecr_repository.cluster_autoscaler.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "rust" {
  repository = aws_ecr_repository.rust.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "kubectl" {
  repository = aws_ecr_repository.kubectl.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}
