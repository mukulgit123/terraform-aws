resource "aws_lb" "alb_pci" {
  name               = "alb-pci-dss"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.frontend_sg.id}"]
  subnets            = ["${element(aws_subnet.public-subnets.*.id,0)}","${element(aws_subnet.public-subnets.*.id,1)}","${element(aws_subnet.public-subnets.*.id,2)}"]

  tags {
    Name = "pci_dss_alb"
    Environment = "pci_dss_poc"
  }
}

