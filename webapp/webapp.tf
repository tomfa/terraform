provider "aws" {
    region = var.aws_region
}

resource "aws_s3_bucket" "mybucket" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "bucket_controls" {
  bucket = aws_s3_bucket.mybucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_public_access_block.public_access_block,
    aws_s3_bucket_ownership_controls.bucket_controls
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_bucket_cors_configuration" "cors" {
  bucket = aws_s3_bucket.mybucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_policy" "allow_get_object" {
  bucket = aws_s3_bucket.mybucket.id
  policy = data.aws_iam_policy_document.allow_get_object.json
}

data "aws_iam_policy_document" "allow_get_object" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.mybucket.arn}/*",
    ]
  }
}

resource "aws_cloudfront_distribution" "distribution" {
    origin {
        domain_name = aws_s3_bucket_website_configuration.website_config.website_endpoint
        origin_id   = "S3-${aws_s3_bucket.mybucket.bucket}"

        custom_origin_config  {
            http_port = 80
            https_port = 443
            origin_protocol_policy = "http-only"
            origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
        }
    }
    default_root_object = "index.html"
    enabled             = true

    custom_error_response {
        error_caching_min_ttl = 3000
        error_code            = 404
        response_code         = var.error_code
        response_page_path    = var.error_path
    }

    custom_error_response {
        error_caching_min_ttl = 3000
        error_code            = 403
        response_code         = var.error_code
        response_page_path    = var.error_path
    }

    aliases = var.domain_aliases

    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.mybucket.bucket}"

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
      }

        viewer_protocol_policy = "redirect-to-https"
        compress               = true
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    # Restricts who is able to access this content
    restrictions {
        geo_restriction {
            # type of restriction, blacklist, whitelist or none
            restriction_type = "none"
        }
    }

    # SSL certificate for the service.
    viewer_certificate {
        cloudfront_default_certificate = var.certificate_arn == "" ? true : false
        acm_certificate_arn = var.certificate_arn
        ssl_support_method = "sni-only"
    }
}
