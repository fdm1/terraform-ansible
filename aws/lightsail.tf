locals {
  "fdm1_lightsail_rsa_key" = "~/.ssh/fdm1_lightsail_key"
}

resource "aws_lightsail_instance" "fdm1_lightsail" {
  name              = "fdm1_lightsail"
  availability_zone = "us-east-1a"
  blueprint_id      = "ubuntu_16_04"
  bundle_id         = "nano_1_0"
  key_pair_name     = "${aws_lightsail_key_pair.fdm1_lightsail_key_pair.name}"
  user_data         = "sudo apt-get update && sudo apt-get install -y ansible"

  provisioner "local-exec" {
    command = <<EOC
pushd ${path.module}
export ANSIBLE_HOST_KEY_CHECKING=False
export LIGHTSAIL_HOST=${self.public_ip_address}
./bin/ansible --no-set-hosts playbook ansible/lightsail-server.yml
popd
EOC
  }
}

resource "aws_lightsail_key_pair" "fdm1_lightsail_key_pair" {
  name       = "fdm1_lightsail_key_pair"
  public_key = "${file("${local.fdm1_lightsail_rsa_key}.pub")}"
}
