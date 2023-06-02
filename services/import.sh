SERVICE_NAME=homepage

terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].aws_ecr_repository.this" "t/pauwels-labs-main/github/pauwels-labs/$SERVICE_NAME"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].aws_ecr_repository.this_cache" "t/pauwels-labs-main/github/pauwels-labs/$SERVICE_NAME/cache"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].aws_ecr_repository_policy.this" "t/pauwels-labs-main/github/pauwels-labs/$SERVICE_NAME"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].aws_ecr_repository_policy.this_cache" "t/pauwels-labs-main/github/pauwels-labs/$SERVICE_NAME/cache"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].github_branch_default.this" "$SERVICE_NAME"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].github_repository.this" "$SERVICE_NAME"

terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].github_repository_file.externalsecret_ssh_cd" "team-main/workload/externalsecret-ssh-pauwels-labs-main-github-pauwels-labs-$SERVICE_NAME.yaml"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].github_repository_file.externalsecret_ssh_ci" "team-main/infra/externalsecret-ssh-pauwels-labs-main-github-pauwels-labs-$SERVICE_NAME.yaml"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].github_repository_file.workload" "team-main/workload/$SERVICE_NAME.yaml"

terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.config[0]" "secrets/data/tenants/t-pauwels-labs-main/configs/base/$SERVICE_NAME-dev/config"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.config[1]" "secrets/data/tenants/t-pauwels-labs-main/configs/base/$SERVICE_NAME-staging/config"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.config[2]" "secrets/data/tenants/t-pauwels-labs-main/configs/base/$SERVICE_NAME-prod/config"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.config[3]" "secrets/data/tenants/t-pauwels-labs-main/configs/dev/$SERVICE_NAME-dev/config"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.config[4]" "secrets/data/tenants/t-pauwels-labs-main/configs/staging/$SERVICE_NAME-staging/config"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.config[5]" "secrets/data/tenants/t-pauwels-labs-main/configs/prod/$SERVICE_NAME-prod/config"

terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[0]" "secrets/data/tenants/t-pauwels-labs-main/configs/base/$SERVICE_NAME-dev/env"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[1]" "secrets/data/tenants/t-pauwels-labs-main/configs/base/$SERVICE_NAME-staging/env"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[2]" "secrets/data/tenants/t-pauwels-labs-main/configs/base/$SERVICE_NAME-prod/env"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[3]" "secrets/data/tenants/t-pauwels-labs-main/configs/dev/$SERVICE_NAME-dev/env"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[4]" "secrets/data/tenants/t-pauwels-labs-main/configs/staging/$SERVICE_NAME-staging/env"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[5]" "secrets/data/tenants/t-pauwels-labs-main/configs/prod/$SERVICE_NAME-prod/env"

terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.repository_ssh_cd" "secrets/data/tenants/t-pauwels-labs-main/repositories/github/pauwels-labs/$SERVICE_NAME/ssh/cd"
terraform import -var-file pauwels-labs-main.tfvars "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.repository_ssh_ci" "secrets/data/tenants/t-pauwels-labs-main/repositories/github/pauwels-labs/$SERVICE_NAME/ssh/ci"


terraform state rm "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[5]" && terraform state rm "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[4]" && terraform state rm "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[3]" && terraform state rm "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[2]" && terraform state rm "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[1]" && terraform state rm "module.services[\"$SERVICE_NAME\"].vault_kv_secret_v2.env[0]"
