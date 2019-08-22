terraform {
  backend "s3" {
    # TODO: make this bucket a variable
    bucket = "fdm1-default-bucket"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}
