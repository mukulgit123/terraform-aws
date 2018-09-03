/*
  NAT Instance
*/
resource "aws_security_group" "sg_nat" {
    name = "sg_nat"
    description = "Allow traffic to pass from the private subnet to the internet"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
	security_groups = ["${aws_security_group.frontend_sg.id}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
	security_groups = ["${aws_security_group.frontend_sg.id}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
	security_groups = ["${aws_security_group.frontend_sg.id}"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
 	security_groups = ["${aws_security_group.frontend_sg.id}"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.drupal-vpc.id}"

    tags {
        Name = "drupal-vpc-nat-security-group"
    }
}
