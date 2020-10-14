provider "aws" {
    region = var.aws_region
}

resource "aws_iam_user" "bucket_user" {
    name = "${var.bucket_name}-user"
    tags = {}
}

resource "aws_iam_user_policy" "user_policy" {
    name = "test"
    user = aws_iam_user.bucket_user.name
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        }
   ]
}
EOF
}

resource "aws_iam_access_key" "bucket_user" {
    user = aws_iam_user.bucket_user.name
}

resource "aws_s3_bucket" "mybucket" {
    bucket = var.bucket_name
    acl = "public-read"

    website {
        redirect_all_requests_to = "index.html"
    }

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        }
    ]
}
EOF
}

resource "aws_cloudfront_distribution" "distribution" {
    origin {
        domain_name = aws_s3_bucket.mybucket.website_endpoint
        origin_id   = "S3-${aws_s3_bucket.mybucket.bucket}"

        custom_origin_config  {
            http_port = 80
            https_port = 443
            origin_protocol_policy = "https-only"
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
