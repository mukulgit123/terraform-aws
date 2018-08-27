output "public_ip" {
  value = "${aws_instance.open_vpn.public_ip}"
}
