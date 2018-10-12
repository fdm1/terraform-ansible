output "fdm1_lightsail_rsa_key" {
  value = "~/.ssh/fdm1_lightsail_key"
}

output "host_ips" {
  value = "${merge(module.aws.host_ips, module.do.host_ips)}"
}
