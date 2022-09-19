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

resource "aws_ecr_repository_policy" "pauwels_labs_redact_website" {
  repository = aws_ecr_repository.pauwels_labs_redact_website.name
  policy = data.aws_iam_policy_document.pauwels_labs_ecr_policy.json
}

resource "aws_ecr_repository_policy" "pauwels_labs_redact_website_cache" {
  repository = aws_ecr_repository.pauwels_labs_redact_website_cache.name
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
