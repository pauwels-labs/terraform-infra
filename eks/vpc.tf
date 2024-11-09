data "aws_availability_zones" "available" {
  provider = aws.cluster

  state = "available"
}

resource "aws_vpc" "cluster" {
  provider = aws.cluster

  cidr_block           = var.cluster_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  assign_generated_ipv6_cidr_block = var.use_ipv6

  tags = {
    Name        = var.cluster_name
    Description = "VPC for the ${var.cluster_name} EKS clusters"
    Cluster     = var.cluster_name
  }
}

resource "aws_subnet" "private" {
  provider = aws.cluster
  count    = local.subnet_count

  vpc_id                              = aws_vpc.cluster.id
  #cidr_block                          = var.use_ipv6 ? null : cidrsubnet(var.cluster_vpc_cidr, 8, count.index)
  cidr_block                          = cidrsubnet(var.cluster_vpc_cidr, 8, count.index)
  availability_zone                   = data.aws_availability_zones.available.names[count.index % local.az_count]
  map_public_ip_on_launch             = false
  private_dns_hostname_type_on_launch = "resource-name"
  #ipv6_native                         = var.use_ipv6
  ipv6_native                         = false
  enable_dns64                        = var.use_ipv6
  assign_ipv6_address_on_creation     = var.use_ipv6
  ipv6_cidr_block                     = var.use_ipv6 ? cidrsubnet(aws_vpc.cluster.ipv6_cidr_block, 8, count.index) : null

  tags = tomap({
    Name = "${var.cluster_name}-${floor(count.index / local.az_count)}-private-${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    Description = "Private subnet in the ${data.aws_availability_zones.available.names[count.index % local.az_count]} AZ for the ${var.cluster_name} EKS clusters"
    Cluster = "${var.cluster_name}-${floor(count.index / local.az_count)}"
    Type = "private"
    AZ = "${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    "kubernetes.io/cluster/${var.cluster_name}-${floor(count.index / local.az_count)}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  })
}

resource "aws_subnet" "public" {
  provider = aws.cluster
  count    = local.subnet_count

  vpc_id                              = aws_vpc.cluster.id
  #cidr_block                          = var.use_ipv6 ? null : cidrsubnet(var.cluster_vpc_cidr, 8, count.index + local.subnet_count)
  cidr_block                          = cidrsubnet(var.cluster_vpc_cidr, 8, count.index + local.subnet_count)

  availability_zone                   = data.aws_availability_zones.available.names[count.index % local.az_count]
  map_public_ip_on_launch             = false
  private_dns_hostname_type_on_launch = "resource-name"
  #ipv6_native                         = var.use_ipv6
  ipv6_native                         = false
  enable_dns64                        = var.use_ipv6
  assign_ipv6_address_on_creation     = var.use_ipv6
  ipv6_cidr_block                     = var.use_ipv6 ? cidrsubnet(aws_vpc.cluster.ipv6_cidr_block, 8, 100 + count.index) : null

  tags = tomap({
    Name = "${var.cluster_name}-${floor(count.index / local.az_count)}-public-${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    Description = "Public subnet in the ${data.aws_availability_zones.available.names[count.index % local.az_count]} AZ for the ${var.cluster_name} EKS clusters"
    Cluster = "${var.cluster_name}-${floor(count.index / local.az_count)}"
    Type = "public"
    AZ = "${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    "kubernetes.io/cluster/${var.cluster_name}-${floor(count.index / local.az_count)}" = "shared"
    "kubernetes.io/role/elb" = "1"
  })
}

resource "aws_subnet" "public_nat_gateways" {
  provider = aws.cluster
  count    = local.nat_gateway_count

  vpc_id                              = aws_vpc.cluster.id
  #cidr_block                          = var.use_ipv6 ? null : cidrsubnet(var.cluster_vpc_cidr, 8, count.index + (2 * local.subnet_count))
  cidr_block                          = cidrsubnet(var.cluster_vpc_cidr, 8, count.index + (2 * local.subnet_count))
  availability_zone                   = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch             = false
  private_dns_hostname_type_on_launch = "resource-name"
  #ipv6_native                         = var.use_ipv6
  ipv6_native                         = false
  enable_dns64                        = var.use_ipv6
  assign_ipv6_address_on_creation     = var.use_ipv6
  ipv6_cidr_block                     = var.use_ipv6 ? cidrsubnet(aws_vpc.cluster.ipv6_cidr_block, 8, 200 + count.index) : null


  tags = {
    Name        = "${var.cluster_name}-public-nat-gateway-${data.aws_availability_zones.available.names[count.index]}"
    Description = "Contains the public NAT gateway in the ${data.aws_availability_zones.available.names[count.index]} AZ for the ${var.cluster_name} EKS clusters"
    Cluster     = var.cluster_name
    Type        = "public"
    AZ          = data.aws_availability_zones.available.names[count.index]
  }  
}

resource "aws_internet_gateway" "cluster" {
  provider = aws.cluster

  vpc_id = aws_vpc.cluster.id

  tags = {
    Name        = var.cluster_name
    Description = "Contains the internet gateway for the ${var.cluster_name} EKS clusters"
    Cluster     = var.cluster_name
  }
}

resource "aws_egress_only_internet_gateway" "cluster" {
  provider = aws.cluster

  vpc_id = aws_vpc.cluster.id

  tags = {
    Name        = var.cluster_name
    Description = "Contains the egress-only internet gateway for the ${var.cluster_name} EKS clusters"
    Cluster     = var.cluster_name
  }
}

resource "aws_eip" "nat_gateways" {
  provider = aws.cluster
  count    = local.nat_gateway_count

  depends_on = [aws_internet_gateway.cluster]

  domain = "vpc"
}

resource "aws_nat_gateway" "public" {
  provider = aws.cluster
  count    = local.nat_gateway_count

  depends_on = [aws_internet_gateway.cluster]

  connectivity_type = "public"
  subnet_id         = aws_subnet.public_nat_gateways[count.index].id
  allocation_id     = aws_eip.nat_gateways[count.index].id

  tags = {
    Name        = "${var.cluster_name}-${aws_subnet.public_nat_gateways[count.index].availability_zone}"
    Description = "Public NAT gateway in the ${aws_subnet.public_nat_gateways[count.index].availability_zone} AZ for the ${var.cluster_name} EKS clusters"
    Cluster     = var.cluster_name
    Type        = "public"
    AZ          = aws_subnet.public_nat_gateways[count.index].availability_zone
  }
}

resource "aws_route_table" "private" {
  provider = aws.cluster
  count    = local.subnet_count

  vpc_id = aws_vpc.cluster.id

  tags = {
    Name        = "${var.cluster_name}-${floor(count.index / local.az_count)}-private-${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    Description = "Routes all requests to IPv4 address and NAT64 IPv6 addresses to a NAT gateway in a public subnet, and the rest of IPv6 addresses to an egress-only internet gateway"
    Cluster     = var.cluster_name
    Type        = "private"
    AZ          = data.aws_availability_zones.available.names[count.index % local.az_count]
  }
}

resource "aws_route" "private_ipv6_to_databases" {
  provider = aws.cluster
  count    = var.use_databases ? local.subnet_count : 0

  route_table_id              = aws_route_table.private[count.index].id
  destination_ipv6_cidr_block = data.aws_vpc.databases[0].ipv6_cidr_block
  vpc_peering_connection_id   = aws_vpc_peering_connection.databases[0].id
}

resource "aws_route" "private_ipv4_to_nat_gateway" {
  provider = aws.cluster
  count    = local.subnet_count

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.public[min(count.index % local.az_count, local.nat_gateway_count - 1)].id
}

resource "aws_route" "private_ipv6_nat64_to_nat_gateway" {
  provider = aws.cluster
  count    = local.subnet_count

  route_table_id              = aws_route_table.private[count.index].id
  destination_ipv6_cidr_block = "64:ff9b::/96"
  nat_gateway_id              = aws_nat_gateway.public[min(count.index % local.az_count, local.nat_gateway_count - 1)].id
}

resource "aws_route" "private_ipv6_to_eigw" {
  provider = aws.cluster
  count    = local.subnet_count

  route_table_id              = aws_route_table.private[count.index].id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.cluster.id
}

resource "aws_route_table_association" "private" {
  provider = aws.cluster
  count    = local.subnet_count

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}

resource "aws_route_table" "public" {
  provider = aws.cluster
  count    = local.subnet_count

  vpc_id = aws_vpc.cluster.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cluster.id
  }
  route {
    ipv6_cidr_block = "64:ff9b::/96"
    nat_gateway_id = aws_nat_gateway.public[min(count.index % local.az_count, local.nat_gateway_count - 1)].id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.cluster.id
  }

  tags = {
    Name        = "${var.cluster_name}-${floor(count.index / local.az_count)}-public-${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    Description = "Routes NAT64 IPv6 addresses to the availability zone's corresponding NAT gateway, and all other IPv6 addresses and all IPv4 addresses to the VPC's internet gateway"
    Cluster      = var.cluster_name
    Type        = "public"
    AZ          = data.aws_availability_zones.available.names[count.index % local.az_count]
  }
}

resource "aws_route_table_association" "public" {
  provider = aws.cluster
  count    = local.subnet_count

  route_table_id = aws_route_table.public[count.index].id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_route_table" "public_nat_gateways" {
  provider = aws.cluster
  count    = local.nat_gateway_count

  vpc_id = aws_vpc.cluster.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cluster.id
  }
  route {
    ipv6_cidr_block = "64:ff9b::/96"
    nat_gateway_id = aws_nat_gateway.public[min(count.index % local.az_count, local.nat_gateway_count - 1)].id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.cluster.id
  }

  tags = {
    Name        = "${var.cluster_name}-public-nat-gateway-${data.aws_availability_zones.available.names[count.index]}"
    Description = "Routes NAT64 IPv6 addresses back to the NAT gateway in this availability zone, and all other IPv6 addresses and all IPv4 addresses to the VPC's internet gateway"
    Cluster      = var.cluster_name
    Type        = "public"
    AZ          = data.aws_availability_zones.available.names[count.index]
  }
}

resource "aws_route_table_association" "public_nat_gateways" {
  provider = aws.cluster
  count    = local.nat_gateway_count

  route_table_id = aws_route_table.public_nat_gateways[count.index].id
  subnet_id      = aws_subnet.public_nat_gateways[count.index].id
}

# Peering
data "aws_vpc" "databases" {
  provider = aws.databases
  count    = var.use_databases ? 1 : 0

  id = var.databases_account_vpc_id
}

resource "aws_vpc_peering_connection" "databases" {
  provider = aws.cluster
  count    = var.use_databases ? 1 : 0

  vpc_id        = aws_vpc.cluster.id
  peer_owner_id = var.databases_account_id
  peer_vpc_id   = var.databases_account_vpc_id
  peer_region   = var.cluster_region

  tags = {
    Name        = "k8s-databases-peering-${var.cluster_name}"
    Description = "Establishes a peering connection between the ${var.cluster_name} EKS cluster VPC and the databases VPC"
    Cluster      = var.cluster_name
  }
}

resource "aws_vpc_peering_connection_options" "requester" {
  provider = aws.cluster
  count    = var.use_databases ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.databases[0].id
  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_accepter" "databases" {
  provider = aws.databases
  count    = var.use_databases ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection.databases[0].id
  auto_accept               = true

  tags = {
    Name        = "k8s-databases-peering-${var.cluster_name}"
    Description = "Establishes a peering connection between the ${var.cluster_name} EKS cluster VPC and the databases VPC"
    Cluster      = var.cluster_name
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  provider = aws.databases
  count    = var.use_databases ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.databases[0].id
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_security_group_rule" "allow_requests_from_cluster_to_database" {
  provider = aws.databases
  count    = var.use_databases ? 1 : 0

  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  ipv6_cidr_blocks  = [aws_vpc.cluster.ipv6_cidr_block]
  security_group_id = var.databases_account_security_group_id
}

resource "aws_route" "to_cluster_from_databases_ipv6" {
  provider = aws.databases
  count    = var.use_databases ? 1 : 0

  route_table_id              = var.databases_account_route_table_id
  destination_ipv6_cidr_block = aws_vpc.cluster.ipv6_cidr_block
  vpc_peering_connection_id   = aws_vpc_peering_connection_accepter.databases[0].vpc_peering_connection_id
}
