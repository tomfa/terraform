output "AWS_SECRET_ACCESS_KEY" {
  value = aws_iam_access_key.bucket_user.secret
}

output "AWS_ACCESS_KEY_ID" {
  value = aws_iam_access_key.bucket_user.id
}

output "S3_FILES_UPLOAD_URL" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}
