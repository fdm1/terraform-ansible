resource "aws_lightsail_instance" "fdm1_lightsail" {
  name              = "fdm1_lightsail"
  availability_zone = "us-east-1a"
  blueprint_id      = "ubuntu_16_04"
  bundle_id         = "nano_1_0"
  key_pair_name     = "${aws_lightsail_key_pair.ssh_keys.0.name}"                                    # 1 key pair is required
  user_data         = "cat ${join("\n", values(var.ssh_keys))} >> /home/ubuntu/.ssh/authorized_keys" # allow all keys to log in for ansibleing

  provisioner "local-exec" {
    command = "resources/remote_server_provisioner.sh lightsail ${self.public_ip_address}"
  }
}
