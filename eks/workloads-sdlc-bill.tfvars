cluster_count        = 1
cluster_region       = "eu-west-1"
cluster_name         = "bill"
cluster_description  = "Contains client hosted workloads"
cluster_version      = "1.23"
cluster_vpc_cidr     = "10.10.0.0/16"
cluster_service_cidr = "10.100.0.0/16"
ha_nat_gateways      = false

az_count = 3

cluster_account_id               = "601743579976"
cluster_account_assume_role_name = "OrganizationAccountAccessRole"

keys_account_id               = "760517686064"
keys_account_assume_role_name = "OrganizationAccountAccessRole"

dns_account_id               = "114374921412"
dns_account_assume_role_name = "OrganizationAccountAccessRole"

databases_account_id                = "276364290766"
databases_account_assume_role_name  = "OrganizationAccountAccessRole"
databases_account_vpc_id            = "vpc-03034899ab886850d"
databases_account_security_group_id = "sg-0c87d33a0ef5755ea"
databases_account_route_table_id    = "rtb-0000d89ed6837d327"

ecr_account_id               = "274295908850"
ecr_account_assume_role_name = "OrganizationAccountAccessRole"

use_flux         = true
use_ecr          = true
ecr_arn          = "arn:aws:ecr:eu-west-1:274295908850:repository/*"
use_external_dns = true
use_cert_manager = true
use_databases    = false
