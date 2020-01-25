# VPC for our application
resource "aws_vpc" "jh_vpc" {
  cidr_block       = var.vpc_cidr
  
  tags = {
    Name = "jhvpc"
  }
}

# Create internet Gateway and attach it to jh_vpc

resource "aws_internet_gateway" "jh_igw" {
  vpc_id = "${aws_vpc.jh_vpc.id}"

  tags = {
    Name = "main"
  }
}
# Building Subnets for VPC
resource "aws_subnet" "public" {
  count = "${length(var.subnets_cidr)}"
  vpc_id     = "${aws_vpc.jh_vpc.id}"
  availability_zone = "${element(var.azs,count.index)}"
  cidr_block = "${element(var.subnets_cidr,count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnets-${count.index + 1}"
  }
}

# Create Route Table, attach IG and associate with public subnet

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.jh_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.jh_igw.id}"
  }

    tags = {
    Name = "publicRT"
  }
}

# Attach Route table with public subnets
resource "aws_route_table_association" "a" {
  count = "${length(var.subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = aws_route_table.public_rt.id
}
