# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "droplet" {
  count = var.droplet_count

  image  = "ubuntu-18-04-x64"
  name   = "droplet-${count.index}"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  ssh_keys  = formatlist("%s", digitalocean_ssh_key.ssh_keys.*.fingerprint)
  user_data = "cat ${join("\n", values(var.ssh_keys))} >> ~/.ssh/authorized_keys"

  provisioner "local-exec" {
    command = "bin/ansible_host_util.py create --host-type digitalocean --ip ${self.ipv4_address} && bin/remote_server_provisioner.sh ${self.ipv4_address}"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "bin/ansible_host_util.py destroy --host-type digitalocean --ip ${self.ipv4_address}"
  }
}
