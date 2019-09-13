resource "aws_lightsail_instance" "lightsail" {
  count = var.lightsail_count

  name              = "lightsail-${count.index}"
  availability_zone = "us-east-1a"
  blueprint_id      = "ubuntu_16_04"
  bundle_id         = "nano_1_0"

  # would be good if this used whatever key was connected and no user-data needed
  # keys:
  # 0 = nfc
  # 1 = usba
  # 2 = usbc

  key_pair_name = aws_lightsail_key_pair.ssh_keys.2.name                                    # 1 key pair is required
  user_data     = "cat ${join("\n", values(var.ssh_keys))} >> /home/ubuntu/.ssh/authorized_keys" # allow all keys to log in for ansibleing

  provisioner "local-exec" {
    command = "bin/ansible_host_util.py create --host-type lightsail --ip ${self.public_ip_address} && bin/remote_server_provisioner.sh ${self.public_ip_address}"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "bin/ansible_host_util.py destroy --host-type lightsail --ip ${self.public_ip_address}"
  }
}
