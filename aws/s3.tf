resource "aws_s3_bucket" "fdm1_default_bucket" {
  bucket = "fdm1-default-bucket"

  versioning {
    enabled = true
  }
}
