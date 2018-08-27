resource "aws_instance" "open_vpn" {
    ami = "${var.ami-ubuntu}"
    availability_zone = "${var.aws_az}"
    instance_type = "${var.aws_vpn_instance}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.open_vpn_sg.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "open_vpn_server"
	Environment = "pci_dss_poc"
    }
}

resource "aws_eip" "open_vpn_eip" {
    instance = "${aws_instance.open_vpn.id}"
    vpc = true
}

