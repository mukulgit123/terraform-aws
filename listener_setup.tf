resource "aws_lb_listener" "pci_lb_listener" {
  load_balancer_arn = "${aws_lb.alb_pci.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${var.self_signed_arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb_pci_tg.arn}"
  }
}
