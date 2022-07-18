data "aws_availability_zones" "available" {
  provider = aws.cluster

  state = "available"
}

resource "aws_vpc" "cluster" {
  provider = aws.cluster

  cidr_block           = var.cluster_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = var.cluster_name
    Description = "VPC for the ${var.cluster_name} EKS clusters"
    Cluster     = var.cluster_name
  }
}

resource "aws_subnet" "private" {
  provider = aws.cluster
  count    = local.subnet_count

  vpc_id                          = aws_vpc.cluster.id
  cidr_block                      = cidrsubnet(var.cluster_vpc_cidr, 8, count.index)
  availability_zone               = data.aws_availability_zones.available.names[count.index % local.az_count]
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = {
    Name        = "${var.cluster_name}-${floor(count.index / local.az_count)}-private-${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    Description = "Private subnet in the ${data.aws_availability_zones.available.names[count.index % local.az_count]} AZ for the ${var.cluster_name} EKS clusters"
    Cluster     = "${var.cluster_name}-${floor(count.index / local.az_count)}"
    Type        = "private"
    AZ          = data.aws_availability_zones.available.names[count.index % local.az_count]
  }
}

resource "aws_subnet" "public" {
  provider = aws.cluster
  count    = local.subnet_count

  vpc_id                          = aws_vpc.cluster.id
  cidr_block                      = cidrsubnet(var.cluster_vpc_cidr, 8, count.index + local.subnet_count)
  availability_zone               = data.aws_availability_zones.available.names[count.index % local.az_count]
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = {
    Name        = "${var.cluster_name}-${floor(count.index / local.az_count)}-public-${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    Description = "Public subnet in the ${data.aws_availability_zones.available.names[count.index % local.az_count]} AZ for the ${var.cluster_name} EKS clusters"
    Cluster     = "${var.cluster_name}-${floor(count.index / local.az_count)}"
    Type        = "public"
    AZ          = data.aws_availability_zones.available.names[count.index % local.az_count]
  }  
}

resource "aws_subnet" "public_nat_gateways" {
  provider = aws.cluster
  count    = local.nat_gateway_count

  vpc_id                          = aws_vpc.cluster.id
  cidr_block                      = cidrsubnet(var.cluster_vpc_cidr, 8, count.index + (2 * local.subnet_count))
  availability_zone               = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

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

resource "aws_eip" "nat_gateways" {
  provider = aws.cluster
  count    = local.nat_gateway_count

  vpc = true
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

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public[min(count.index % local.az_count, local.nat_gateway_count - 1)].id
  }

  tags = {
    Name        = "${var.cluster_name}-${floor(count.index / local.az_count)}-private-${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    Description = "Routes outbound requests to non-local IPs to a NAT gateway in a public subnet"
    Cluster     = var.cluster_name
    Type        = "private"
    AZ          = data.aws_availability_zones.available.names[count.index % local.az_count]
  }
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

  tags = {
    Name        = "${var.cluster_name}-${floor(count.index / local.az_count)}-public-${data.aws_availability_zones.available.names[count.index % local.az_count]}"
    Description = "Routes outbound requests to non-local IPs to the VPC internet gateway"
    Cluter      = var.cluster_name
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
  count    = local.subnet_count

  vpc_id = aws_vpc.cluster.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cluster.id
  }

  tags = {
    Name        = "${var.cluster_name}-public-nat-gateway-${data.aws_availability_zones.available.names[count.index]}"
    Description = "Routes outbound requests to non-local IPs to the VPC internet gateway"
    Cluter      = var.cluster_name
    Type        = "public"
    AZ          = data.aws_availability_zones.available.names[count.index]
  }
}

resource "aws_route_table_association" "public_nat_gateways" {
  provider = aws.cluster
  count    = local.subnet_count

  route_table_id = aws_route_table.public_nat_gateways[count.index].id
  subnet_id      = aws_subnet.public_nat_gateways[count.index].id
}
