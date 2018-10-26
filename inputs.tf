variable "digitalocean_token" {
  description = "DO token. Stored in secrets in S3"
}

variable "ssh_keys" {
  description = "Map of SSH pubkeys. Stored in secrets in S3"
  type        = "map"
}

variable "lightsail_count" {}
variable "droplet_count" {}
