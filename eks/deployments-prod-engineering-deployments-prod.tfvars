cluster_count        = 1
cluster_region       = "eu-west-1"
cluster_name         = "lefranc"
cluster_description  = "Contains infrastructure management services for Pauwels Labs"
cluster_version      = "1.22"
cluster_vpc_cidr     = "10.10.0.0/16"
cluster_service_cidr = "10.100.0.0/16"
ha_nat_gateways      = false

az_count = 3

cluster_account_id               = "140327370353"
cluster_account_assume_role_name = "OrganizationAccountAccessRole"

keys_account_id               = "760517686064"
keys_account_assume_role_name = "OrganizationAccountAccessRole"
