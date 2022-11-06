resource "aws_vpc" "this" {
  provider = aws.databases

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  assign_generated_ipv6_cidr_block = var.use_ipv6

  tags = {
    Name        = "aurora-pgsql-${var.name}"
    Description = "VPC for the ${var.name} AWS Aurora Serverless v2 PostgreSQL cluster"
    Cluster     = var.name
  }
}

data "aws_availability_zones" "available" {
  provider = aws.databases

  state = "available"
}

resource "aws_subnet" "private" {
  provider = aws.databases
  count    = local.az_count

  vpc_id                              = aws_vpc.this.id
  #cidr_block                          = var.use_ipv6 ? null : cidrsubnet(var.vpc_cidr, 8, count.index + local.subnet_count)
  cidr_block                          = cidrsubnet(var.vpc_cidr, 8, count.index)

  availability_zone                   = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch             = false
  private_dns_hostname_type_on_launch = "resource-name"
  #ipv6_native                         = var.use_ipv6
  ipv6_native                         = false
  enable_dns64                        = var.use_ipv6
  assign_ipv6_address_on_creation     = var.use_ipv6
  ipv6_cidr_block                     = var.use_ipv6 ? cidrsubnet(aws_vpc.this.ipv6_cidr_block, 8, count.index) : null

  tags = tomap({
    Name = "aurora-pgsql-private-${data.aws_availability_zones.available.names[count.index]}-${var.name}"
    Description = "Private subnet in the ${data.aws_availability_zones.available.names[count.index]} AZ for the ${var.name} Aurora Serverless v2 PostgreSQL cluster"
    Cluster = var.name
    Type = "private"
    AZ = "${data.aws_availability_zones.available.names[count.index]}"
  })
}

resource "aws_route_table" "all_private" {
  provider = aws.databases

  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "aurora-pgsql-peering-private-${var.name}"
    Description = "Collects all routes for connecting the ${var.name} Aurora Serverless v2 PostgreSQL database subnets to peering connections to other VPCs"
    Cluster     = var.name
    Type        = "peering"
  }
}

resource "aws_route_table_association" "private" {
  provider = aws.databases
  count    = local.az_count

  route_table_id = aws_route_table.all_private.id
  subnet_id      = aws_subnet.private[count.index].id
}
