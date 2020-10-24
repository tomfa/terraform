provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl = var.acl
}
