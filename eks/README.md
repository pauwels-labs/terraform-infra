# EKS Cluster Creation

This module creates up to 25 identical EKS clusters in the same VPC. The architecture is as follows:

- Exactly one VPC is created and shared amongst all clusters; to create clusters in separate VPCs, simply deploy this module multiple times

- Each cluster receives both public and private subnets
  
  - One private and public subnet pair is deployed per availability zone
  
  - The number of availability zones deployed to depends on both the requested number of AZs and the actual number of AZs available in the selected region (whichever is smaller)
  
  - Each subnet receives a /24 CIDR block; since the maximum number of AZs in any AWS region is 5, this creates a maximum of 10 subnets per cluster * 25 clusters = 250 subnets, which fits in the 256 subnets available in a /24 block within a /16 VPC IP block
  
  - A cluster can deploy as many pods as there are IPs available to it, so 256 * number of AZs
  
- NAT gateways and internet gateways are shared across all deployed clusters

  - NAT gateways are deployed to dedicated subnets within the VPC and are not placed in the same subnets as those associated with EKS clusters
  
  - NAT gateways can be deployed in standard or HA mode; in standard mode, one NAT gateway is deployed, while in HA mode one NAT gateway is deployed per AZ
  
  - Since EKS clusters consume a maximum of 250 /24 subnets, and a region has a maximum of 5 AZs, this consumes at most 255 total subnets, with 1 reserved
  
  - Only a single internet gateway is deployed to the VPC as it is managed by AWS, HA, and horizontally scales
