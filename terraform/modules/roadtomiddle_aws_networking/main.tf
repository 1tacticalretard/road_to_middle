resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.common_name}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.common_name}-internet_gateway"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidr_list)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnet_cidr_list, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.common_name}-public_subnet-${count.index + 1}"
    Tier = "Public"
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "${var.common_name}-route_table_public"
  }
}

resource "aws_route_table_association" "rt_association_public" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.route_table_public.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)

}

resource "aws_eip" "elastic_ip" {
  count = length(var.private_subnet_cidr_list)
  vpc   = true
  tags = {
    Name = "${var.common_name}-nat_gateway-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.private_subnet_cidr_list)
  allocation_id = aws_eip.elastic_ip[count.index].id
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
  tags = {
    Name = "${var.common_name}-nat_gateway-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidr_list)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnet_cidr_list, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.common_name}-private_subnet-${count.index + 1}"
    Tier = "Private"
  }
}

resource "aws_route_table" "route_table_private" {
  count  = length(var.private_subnet_cidr_list)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
  tags = {
    Name = "${var.common_name}-route_table_private-${count.index + 1}"
  }
}

resource "aws_route_table_association" "route_table_association_private" {
  count          = length(aws_subnet.private_subnets[*].id)
  route_table_id = aws_route_table.route_table_private[count.index].id
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
}

resource "aws_security_group" "security_group" {
  name        = "${var.common_name}-security_group"
  description = "A security group which allows 80, 443, 22, 9090 ports ingress and any port egress."
  vpc_id      = aws_vpc.vpc.id
  dynamic "ingress" {
    for_each = var.security_group_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.common_name}-security_group"
  }
}
