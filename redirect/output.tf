output "BUCKET_ZONE_ID" {
  value = aws_s3_bucket.redirect.hosted_zone_id
}

output "BUCKET_WEBSITE_DOMAIN" {
  value = aws_s3_bucket.redirect.website_domain
}
