output "host_ips" {
  value = {
    lightsail = aws_lightsail_instance.lightsail.*.public_ip_address
  }
}
