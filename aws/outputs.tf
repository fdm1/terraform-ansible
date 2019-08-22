output "host_ips" {
  value = {
    LIGHTSAIL_HOST = "${aws_lightsail_instance.lightsail.*.public_ip_address}"
  }
}
