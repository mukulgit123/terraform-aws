output "vpn_public_ip" {
  value = "${aws_instance.open_vpn.public_ip}"
}

output "nat_public_ip" {
  value = "${aws_instance.nat-instance.public_ip}" 
}
