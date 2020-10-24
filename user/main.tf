provider "aws" {}

resource "aws_iam_user" "bucket_user" {
  name = var.iam_user_name
  tags = {}
}

resource "aws_iam_user_policy" "s3_user_policy" {
  count = length(var.bucket_names) > 0 ? 1 : 0
  name = "${var.iam_user_name}-s3-upload"
  user = aws_iam_user.bucket_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect: "Allow",
        Action: "s3:*",
        Resource = [for bucket_name in var.bucket_names : "arn:aws:s3:::${bucket_name}/*"]
      }
    ]
  })
}

resource "aws_iam_user_policy" "cloudfront_user_policy" {
  count = length(var.cloudfront_distribution_ids) > 0 ? 1 : 0
  name = "${var.iam_user_name}-cloudfront-invalidation"
  user = aws_iam_user.bucket_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect: "Allow",
        Action: [
          "cloudfront:CreateInvalidation",
          "cloudfront:GetInvalidation",
          "cloudfront:ListInvalidations",
          "cloudfront:ListDistributions"
        ],
        # individual distribution IAM access control is not supported
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_access_key" "bucket_user" {
  user = aws_iam_user.bucket_user.name
}
