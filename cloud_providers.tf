module "aws" {
  source = "./aws"

  ssh_keys = "${var.ssh_keys}"
}

module "do" {
  source = "./digitalocean"

  ssh_keys = "${var.ssh_keys}"
}
