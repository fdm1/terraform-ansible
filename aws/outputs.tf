output "host_ips" {
  value = {
    LIGHTSAIL_HOST = "${aws_lightsail_instance.fdm1_lightsail.*.public_ip_address}"
  }
}
