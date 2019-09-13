# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "web" {
  count = var.droplet_count

  image  = "ubuntu-18-04-x64"
  name   = "web-1"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  ssh_keys  = formatlist("%s", digitalocean_ssh_key.ssh_keys.*.fingerprint)
  user_data = "cat ${join("\n", values(var.ssh_keys))} >> ~/.ssh/authorized_keys"

  provisioner "local-exec" {
    command = "resources/remote_server_provisioner.sh digitalocean ${self.ipv4_address}"
  }
}
