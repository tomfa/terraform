provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "redirect" {
  bucket = var.bucket_name
  acl    = "private"

  website {
    redirect_all_requests_to = var.redirect_url
  }
}
