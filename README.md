# terraform-infra
All Terraform-based infrastructure lives here

# VPC CIDRs

VPC for engineering-deployments-prod-0 EKS cluster in eu-west-1:
10.10.0.0/16

VPC for prod aurora postgres serverless server:
10.20.0.0/16

# Authentication

Some components need tokens for authenticating to certain services,
namely:

1. GitHub tokens required for flux/ and repositories/ modules

2. Keycloak token required for the keycloak/ module

In cases where manually provided tokens are required, a
`config.env.tmpl` is provided in the module which contains all the
environment variables which would be required in a `*.env`
file. Simply copy the file to `config.env`, fill in the details, and
`source config.env` for authentication to work.

# Caveats

## EKS

### Destroy before apply

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

### Destroy after apply

This will fail because the IPv6 CNI policy will still be attached to
node groups. When it fails, do the following:

1. Run `terraform apply -var-file <varfile> -target random_id.suffix`
   to re-generate the required random suffixes

2. Set the `cluster_count` to `0`

3. Run `terraform destroy -var-file <varfile>` to complete the destroy

### Running apply

After running apply, run apply again. Some missing labels will create
a one-time diff and then it should be good to go!

## Flux

### Can't apply CRDs and CRs at same time

Initially, comment out the kubernetes_manifest.flux_sync_content_c0
resource. Run apply, and let things complete. This will install Flux
core components and CRDs into the cluste. Then you can add the sync
components back in which will install the CRs dependent on the CRDs.
