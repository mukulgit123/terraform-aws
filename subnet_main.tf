resource "aws_subnet" "public-subnets" {
   vpc_id            = "${aws_vpc.drupal-vpc.id}"
   count             = "${length(split(",", lookup(var.azs, var.aws_region)))}"
   cidr_block        = "${cidrsubnet(var.vpc["cidr_block"], var.vpc["subnet_bits"], count.index)}"
   availability_zone = "${element(split(",", lookup(var.azs, var.aws_region)), count.index)}"
   tags {
       Name          = "${var.vpc["tag"]}-public-subnet-${count.index}"
       drupal-vpc   = "${lower(var.vpc["tag"])}"
   }
   map_public_ip_on_launch = true
}

resource "aws_subnet" "private-subnets-application" {
   vpc_id            = "${aws_vpc.drupal-vpc.id}"
   count             = "${length(split(",", lookup(var.azs, var.aws_region)))}"
   cidr_block        = "${cidrsubnet(var.vpc["cidr_block"], var.vpc["subnet_bits"], count.index + length(split(",", lookup(var.azs, var.aws_region))))}"
   availability_zone = "${element(split(",", lookup(var.azs, var.aws_region)), count.index + length(split(",", lookup(var.azs, var.aws_region))))}"
   tags {
       Name          = "${var.vpc["tag"]}-private-subnet-app-${count.index}"
       drupal-vpc   = "${lower(var.vpc["tag"])}"
       Network       = "private"
   }
}

resource "aws_subnet" "private-subnets-DB" {
   vpc_id            = "${aws_vpc.drupal-vpc.id}"
   count             = "${length(split(",", lookup(var.azs, var.aws_region)))}"
   cidr_block        = "${cidrsubnet(var.vpc["cidr_block"], var.vpc["subnet_bits"], count.index + (2 * length(split(",", lookup(var.azs, var.aws_region)))))}"
   availability_zone = "${element(split(",", lookup(var.azs, var.aws_region)), count.index + (2 * length(split(",", lookup(var.azs, var.aws_region)))))}"
   tags {
       Name          = "${var.vpc["tag"]}-private-subnetdb-${count.index}"
       drupal-vpc   = "${lower(var.vpc["tag"])}"
       Network       = "private"
   }
}
/*======NAT GATEWAY=======*/
resource "aws_nat_gateway" "app-gw" {
  allocation_id = "${aws_eip.nat-eip.id}"
  subnet_id     = "${element(aws_subnet.public-subnets.*.id, count.index)}"
  depends_on = ["aws_internet_gateway.drupal-gateway"]
  tags {
    Name = "${var.vpc["tag"]}-nat-gateway"
  }
}

/*=== ROUTING TABLES ===*/
resource "aws_route_table" "public-subnet-rt" {
   vpc_id = "${aws_vpc.drupal-vpc.id}"
   route {
       cidr_block = "0.0.0.0/0"
       gateway_id = "${aws_internet_gateway.drupal-gateway.id}"
   }
   tags {
       Name        = "${var.vpc["tag"]}-public-subnet-route-table"
       drupal-vpc = "${lower(var.vpc["tag"])}"
   }
}

resource "aws_route_table_association" "public-subnet-rta" {
   count          = "${length(split(",", lookup(var.azs, var.aws_region)))}"
   subnet_id      = "${element(aws_subnet.public-subnets.*.id, count.index)}"
   route_table_id = "${aws_route_table.public-subnet-rt.id}"
}

resource "aws_route_table" "private-subnet-rt" {
   vpc_id = "${aws_vpc.drupal-vpc.id}"
   route {
       cidr_block = "0.0.0.0/0"
       nat_gateway_id = "${aws_nat_gateway.app-gw.id}"
   }
   tags {
       Name        = "${var.vpc["tag"]}-private-subnet-route-table"
       drupal-vpc = "${lower(var.vpc["tag"])}"
   }
}

resource "aws_route_table_association" "private-subnet-application-rta" {
   count          = "${length(split(",", lookup(var.azs, var.aws_region)))}"
   subnet_id      = "${element(aws_subnet.private-subnets-application.*.id, count.index + length(split(",", lookup(var.azs, var.aws_region))))}"
   route_table_id = "${aws_route_table.private-subnet-rt.id}"
}


resource "aws_route_table_association" "private-subnet-db-rta" {
   count          = "${length(split(",", lookup(var.azs, var.aws_region)))}"
   subnet_id      = "${element(aws_subnet.private-subnets-DB.*.id, count.index +  (2 * length(split(",", lookup(var.azs, var.aws_region)))))}"
   route_table_id = "${aws_route_table.private-subnet-rt.id}"
}

