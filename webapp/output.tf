output "BUCKET_NAME" {
    value = var.bucket_name
}

output "CLOUDFRONT_URL" {
    value = aws_cloudfront_distribution.distribution.domain_name
}

output "CLOUDFRONT_ZONE_ID" {
    value = aws_cloudfront_distribution.distribution.hosted_zone_id
}

output "AWS_SECRET_ACCESS_KEY" {
    value = aws_iam_access_key.bucket_user.secret
}

output "AWS_ACCESS_KEY_ID" {
    value = aws_iam_access_key.bucket_user.id
}

output "S3_WEBSITE_URL" {
    value = aws_s3_bucket.mybucket.website_endpoint
}
