resource "aws_route53_zone" "hosted_zone" {
  name = "${var.poc_hosted_zone}"
}


