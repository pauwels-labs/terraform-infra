idp_url                   = "https://identity.pauwelslabs.com"
organisation_name         = "bitmantle"
organisation_display_name = "BitMantle"
is_root                   = true
environments              = [
  {
    name     = "dev"
    services = [
      "kubernetes",
      "vault"
    ]
  },
  {
    name     = "staging"
    services = [
      "kubernetes",
      "vault"
    ]
  },
  {
    name     = "prod"
    services = [
      "kubernetes",
      "vault"
    ]
  }
]
teams                     = [
  {
    name = "main"
  }
]
services                  = [
  {
    name                  = "kubernetes"
    description           = "Provides access to Kubernetes clusters"
    standard_flow_enabled = true
    root_url              = "http://localhost:8000"
    base_url              = "http://localhost:8000"
    valid_redirect_uris   = [
      "/*",
      "https://network.pauwelslabs.com/*"
    ]
  },
  {
    name                  = "vault"
    description           = "Provides access to Vault"
    standard_flow_enabled = true
    root_url              = "https://secrets.pauwelslabs.com"
    base_url              = "https://secrets.pauwelslabs.com"
    valid_redirect_uris   = [
      "/ui/vault/auth/$${environment.name}/oidc/callback",
      "http://localhost:8250/oidc/callback"
    ]
  }
]
users                     = [
  {
    username   = "pauwels"
    email      = "alex@pauwelslabs.com"
    first_name = "Alexandre"
    last_name  = "Pauwels"
    gpg_public_key = <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----
Comment: https://keybase.io/download
Version: Keybase Go 5.6.1 (linux)

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
JMLYu90JTqTOYQVo8sjvwsfhB6vfr9YKO/uxr3g=
=c5ZN
-----END PGP PUBLIC KEY BLOCK-----
EOF
  }
]
