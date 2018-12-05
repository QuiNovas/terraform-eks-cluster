data "aws_availability_zones" "current" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"

  tags {
    Name = "${var.prefix}-eks-cluster"
  }
}

resource "aws_internet_gateway" "main" {
  tags {
    Name = "${var.prefix}-eks-cluster"
  }

  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "${var.prefix}-eks-cluster"
  }
}

data "aws_region" "current" {}

resource "aws_route_table_association" "main" {
  count = "${local.availability_zones_count}"

  subnet_id      = "${aws_subnet.main.*.id[count.index]}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_subnet" "main" {
  availability_zone = "${data.aws_availability_zones.current.names[count.index]}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 3, count.index)}"
  count             = "${local.availability_zones_count}"

  tags {
    Name = "${var.prefix}-${data.aws_availability_zones.current.names[count.index]}"
  }

  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_security_group" "main" {
  egress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]

    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }

  name   = "${var.prefix}-eks-cluster"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.prefix}-eks-cluster"
  }
}

resource "aws_security_group_rule" "main-ingress-workstation-https" {
  cidr_blocks       = "${var.whitelist_cidr_blocks}"
  description       = "Allow workstations to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.main.id}"
  to_port           = 443
  type              = "ingress"
}
