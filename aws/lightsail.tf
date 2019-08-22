resource "aws_lightsail_instance" "fdm1_lightsail" {
  count = "${var.lightsail_count}"

  name              = "fdm1_lightsail"
  availability_zone = "us-east-1a"
  blueprint_id      = "ubuntu_16_04"
  bundle_id         = "nano_1_0"

  # would be good if this used whatever key was connected and no user-data needed
  # keys:
  # 0 = nfc
  # 1 = usba
  # 2 = usbc

  key_pair_name = "${aws_lightsail_key_pair.ssh_keys.2.name}"                                    # 1 key pair is required
  user_data     = "cat ${join("\n", values(var.ssh_keys))} >> /home/ubuntu/.ssh/authorized_keys" # allow all keys to log in for ansibleing
  # TODO: breaking on creat user task.
  # "msg": "useradd: Permission denied.\nuseradd: cannot lock /etc/passwd; try again later.\n"
  provisioner "local-exec" {
    command = "resources/remote_server_provisioner.sh lightsail ${self.public_ip_address}"
  }
}
