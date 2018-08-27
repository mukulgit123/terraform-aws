resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.open_vpn_vpc.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags {
        Name = "Public Subnet Open VPN"
	Environment = "pci_dss_poc"
    }
}

resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.open_vpn_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.open_vpn_gateway.id}"
    }

    tags {
        Name = "Public Subnet Open VPN"
	Environment = "pci_dss_poc"
    }
}

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}

/*
  DB Subnet
*/
resource "aws_subnet" "us-east-1a-private" {
    vpc_id = "${aws_vpc.open_vpn_vpc.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags {
        Name = "Private Subnet"
	Environment = "pci_dss_poc"
    }
}

resource "aws_route_table" "us-east-1a-private" {
    vpc_id = "${aws_vpc.open_vpn_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.open_vpn.id}"
    }

    tags {
        Name = "Private Subnet"
	Environment = "pci_dss_poc"
    }
}

resource "aws_route_table_association" "us-east-1a-private" {
    subnet_id = "${aws_subnet.us-east-1a-private.id}"
    route_table_id = "${aws_route_table.us-east-1a-private.id}"
}
