output "BUCKET_NAME" {
    value = var.bucket_name
}

output "CLOUDFRONT_ZONE_ID" {
    value = aws_cloudfront_distribution.distribution.hosted_zone_id
}

output "S3_WEBSITE_URL" {
    value = aws_s3_bucket.mybucket.website_endpoint
}

output "CLOUDFRONT_URL" {
    value = aws_cloudfront_distribution.distribution.domain_name
}

output "ALIAS_URLS" {
    value = aws_cloudfront_distribution.distribution.aliases
}
