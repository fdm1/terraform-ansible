provider "aws" {
  version = "~> 1.31.0"
  region  = "us-east-1"
}

provider "digitalocean" {
  token = "${var.digitalocean_token}"
}
