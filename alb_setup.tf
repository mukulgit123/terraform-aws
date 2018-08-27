resource "aws_lb" "alb_pci" {
  name               = "alb-pci-dss"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.open_vpn_sg.id}"]
  subnets            = ["${aws_subnet.us-east-1a-public.*.id}"]

  enable_deletion_protection = true

  tags {
    Name = "pci_dss_alb"
    Environment = "pci_dss_poc"
  }
}

