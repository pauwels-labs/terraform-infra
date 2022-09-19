provider "aws" {
  region = "eu-west-1"
  profile = "mfa"  
  assume_role {
    role_arn = "arn:aws:iam::274295908850:role/OrganizationAccountAccessRole"
  }  
}

resource "aws_ecr_repository" "pauwels_labs_redact_store" {
  name                 = "pauwels-labs/redact-store"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_store_cache" {
  name                 = "pauwels-labs/redact-store/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
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
  name                 = "pauwels-labs/homepage"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_homepage_cache" {
  name                 = "pauwels-labs/homepage/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
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
  name                 = "pauwels-labs/redact-feed-ui"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_feed_ui_cache" {
  name                 = "pauwels-labs/redact-feed-ui/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_feed_api" {
  name                 = "pauwels-labs/redact-feed-api"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_feed_api_cache" {
  name                 = "pauwels-labs/redact-feed-api/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_website" {
  name                 = "pauwels-labs/redact-website"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "pauwels_labs_redact_website_cache" {
  name                 = "pauwels-labs/redact-website/cache"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
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
  name                 = "kiali/kiali"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "kiali_operator" {
  name                 = "kiali/kiali-operator"
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
