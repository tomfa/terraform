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

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl = var.acl
}

output "AWS_SECRET_ACCESS_KEY" {
  value = aws_iam_access_key.bucket_user.secret
}

output "AWS_ACCESS_KEY_ID" {
  value = aws_iam_access_key.bucket_user.id
}
