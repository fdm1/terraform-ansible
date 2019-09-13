module "aws" {
  source = "./aws"

  ssh_keys        = var.ssh_keys
  lightsail_count = var.lightsail_count
}

module "do" {
  source = "./digitalocean"

  ssh_keys      = var.ssh_keys
  droplet_count = var.droplet_count
}

