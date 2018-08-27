resource "aws_vpc" "open_vpn_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "terraform-openvpn-vpc"
	Environment = "pci_dss_poc"
    }
}

resource "aws_internet_gateway" "open_vpn_gateway" {
    vpc_id = "${aws_vpc.open_vpn_vpc.id}"
}

