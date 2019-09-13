provider "aws" {
  version = "~> 2.28.1"
  region  = "us-east-1"
}

provider "digitalocean" {
  version = "~> 1.7.0"
  token   = var.digitalocean_token
}

