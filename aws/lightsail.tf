locals {
  "fdm1_lightsail_rsa_key" = "~/.ssh/fdm1_lightsail_key"
}

resource "aws_lightsail_instance" "fdm1_lightsail" {
  name              = "fdm1_lightsail"
  availability_zone = "us-east-1a"
  blueprint_id      = "ubuntu_16_04"
  bundle_id         = "nano_1_0"
  key_pair_name     = "${aws_lightsail_key_pair.fdm1_lightsail.name}"

  provisioner "local-exec" {
    command = "resources/remote_server_provisioner.sh lightsail ${self.public_ip_address}"
  }
}

resource "aws_lightsail_key_pair" "fdm1_lightsail" {
  name       = "fdm1_lightsail_key_pair"
  public_key = "${var.ssh_keys["fdm1_lightsail"]}"
}
