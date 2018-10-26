output "host_ips" {
  value = "${merge(module.aws.host_ips, module.do.host_ips)}"
}
