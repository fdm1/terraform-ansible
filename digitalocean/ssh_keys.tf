# Create a new SSH key
resource "digitalocean_ssh_key" "macbook" {
  name       = "macbook ssh key"
  public_key = "${var.ssh_keys["macbook"]}"
}
