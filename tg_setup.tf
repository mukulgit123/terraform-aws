resource "aws_lb_target_group" "alb_pci_tg" {
  name     = "alb-pci-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.drupal-vpc.id}"
}
