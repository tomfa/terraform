output "S3_FILES_UPLOAD_URL" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}
