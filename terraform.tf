terraform {
  backend "s3" {
    bucket = "fdm1-default-bucket"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}
