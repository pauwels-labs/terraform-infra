resource "aws_vpc" "cluster" {
  provider = aws.cluster

  cidr_block           = var.cluster_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "cluster" {
  provider = aws.cluster
  count    = var.cluster_count * local.az_count

  vpc_id                          = aws_vpc.cluster.id
  cidr_block                      = cidrsubnet(cluster_vpc_cidr, 8, count.index)
  availability_zone               = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = {
    Name = "${var.cluster_name}-${floor(count.index / local.az_count)}-${data.aws_availability_zones.available.names[count.index % local.az_count]}"
  }
}

data "aws_availability_zones" "available" {
  provider = aws.cluster

  state = "available"
}
