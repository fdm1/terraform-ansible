module "aws" {
  source = "./aws"
}

module "do" {
  source = "./digitalocean"

  ssh_keys = "${var.ssh_keys}"
}
