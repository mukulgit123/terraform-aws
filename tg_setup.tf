resource "aws_lb_target_group" "alb_pci_tg" {
  name     = "alb_pci_tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.open_vpn_vpc.id}"
}
