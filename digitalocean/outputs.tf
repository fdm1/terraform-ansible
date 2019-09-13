output "host_ips" {
  value = {
    digitalocean = digitalocean_droplet.droplet.*.ipv4_address
  }
}
