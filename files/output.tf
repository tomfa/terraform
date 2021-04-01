output "S3_FILES_UPLOAD_URL" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}

output "BUCKET_NAME" {
  value = var.bucket_name
}

output "CLOUDFRONT_ZONE_ID" {
  value = aws_cloudfront_distribution.distribution.hosted_zone_id
}

output "CLOUDFRONT_URL" {
  value = aws_cloudfront_distribution.distribution.domain_name
}

output "CLOUDFRONT_DISTRIBUTION_ID" {
  value = aws_cloudfront_distribution.distribution.id
}

output "ALIAS_URLS" {
  value = aws_cloudfront_distribution.distribution.aliases
}

