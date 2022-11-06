# terraform-infra
All Terraform-based infrastructure lives here

# VPC CIDRs

VPC for engineering-deployments-prod-0 EKS cluster in eu-west-1:
10.10.0.0/16

VPC for prod aurora postgres serverless server:
10.20.0.0/16

# Caveats

## EKS

If you try to run destroy before applying anything, the operation will
fail. This is because the map of eks_managed_node_groups in the
cluster module has keys dynamically generated from the name of the
availability zone the node group is for. This has no other effect, so
for now I'm keeping it as is in favor of being able to have a dynamic
list of node groups.

The solution would be to define a static set of node groups and
activate them with count. This is possible since we know there are at
most 5 AZs in any region, but it's not really scalable. An
implementation of this is commented out in the eks_managed_node_groups
map, in case it is one day useful.
