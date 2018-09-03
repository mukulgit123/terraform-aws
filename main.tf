resource "aws_vpc" "drupal-vpc" {
    cidr_block = "${var.vpc["cidr_block"]}"
    enable_dns_hostnames = true
    tags {
        Name = "terraform-drupal-vpc"
	Environment = "pci_dss_poc"
    }
}

resource "aws_internet_gateway" "drupal-gateway" {
    vpc_id = "${aws_vpc.drupal-vpc.id}"
}


