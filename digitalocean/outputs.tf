output "host_ips" {
  value = {
    DROPLET_HOST = "${digitalocean_droplet.web.ipv4_address}"
  }
}
