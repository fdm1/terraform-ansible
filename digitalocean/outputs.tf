output "droplet_host" {
  value = "${digitalocean_droplet.web.ipv4_address}"
}
