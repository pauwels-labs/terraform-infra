cluster_count        = 1
cluster_region       = "eu-west-1"
cluster_name         = "lefranc"
cluster_description  = "Contains infrastructure management services for Pauwels Labs"
cluster_version      = "1.27"
cluster_vpc_cidr     = "10.10.0.0/16"
cluster_service_cidr = "10.100.0.0/16"
ha_nat_gateways      = false

az_count = 3

cluster_account_id               = "140327370353"
cluster_account_assume_role_name = "OrganizationAccountAccessRole"

cluster_instance_types = [
  "m5.xlarge",
  "m5d.xlarge",
  "m5a.xlarge",
  "m5ad.xlarge",
  "m5n.xlarge",
  "m5dn.xlarge",
  "m5zn.xlarge",
  "t3.xlarge",
  "t3a.xlarge",
]

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
use_databases    = true
use_mimir        = true
use_loki         = true
mimir_blocks_bucket_arn     = "arn:aws:s3:::mimir-blocks-20221206125509500600000002"
mimir_blocks_key_alias_name = "alias/s3-mimir-blocks-encryption"
mimir_ruler_bucket_arn      = "arn:aws:s3:::mimir-ruler-20221206125509500600000001"
mimir_ruler_key_alias_name  = "alias/s3-mimir-ruler-encryption"
loki_chunks_bucket_arn     = "arn:aws:s3:::loki-chunks-20230531092431228000000002"
loki_chunks_key_alias_name = "alias/s3-loki-chunks-encryption"
loki_ruler_bucket_arn      = "arn:aws:s3:::loki-ruler-20230531092431228300000003"
loki_ruler_key_alias_name  = "alias/s3-loki-ruler-encryption"
loki_admin_bucket_arn     = "arn:aws:s3:::loki-admin-20230531092431227900000001"
loki_admin_key_alias_name = "alias/s3-loki-admin-encryption"
