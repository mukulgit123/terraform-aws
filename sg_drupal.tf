resource "aws_security_group" "frontend_sg" {
    name = "frontend_sg"
    description = "Allow traffic to pass from the public subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
   }

    vpc_id = "${aws_vpc.drupal-vpc.id}"

    tags {
        Name = "drupal-vpc"
        Environment = "pci_dss_poc"
    }
}

resource "aws_security_group" "db_sg" {
    name = "db_sg"
    description = "Allow traffic to pass from the private subnet to the db"

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.frontend_sg.id}"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        security_groups = ["${aws_security_group.frontend_sg.id}"]
    }
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = ["${aws_security_group.frontend_sg.id}"]
    }

    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.drupal-vpc.id}"

    tags {
        Name = "drupal-vpc"
        Environment = "pci_dss_poc"
    }
}

