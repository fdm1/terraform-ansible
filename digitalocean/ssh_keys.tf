# Create a new SSH key
resource "digitalocean_ssh_key" "fdm1_lightsail" {
  name       = "fdm1_lightsail_key_pair"
  public_key = "${var.ssh_keys["fdm1_lightsail"]}"
}
