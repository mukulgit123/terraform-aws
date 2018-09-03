resource "aws_eip" "nat-eip" {
    vpc = true
}

resource "aws_instance" "nat-instance" {
    ami = "${var.nat["ami"]}"
    availability_zone = "${element(split(",", lookup(var.azs, var.aws_region)), 0)}" 
    instance_type = "${var.nat["inst_type"]}"
    key_name = "${var.nat["key_name"]}"
    
    vpc_security_group_ids = ["${aws_security_group.sg_nat.id}"]
    subnet_id = "${element(aws_subnet.public-subnets.*.id, 0)}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "${var.vpc["tag"]}-public-nat-instance"
    }
}
