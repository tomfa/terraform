variable "bucket_names" {
	description = "list of your bucket names that the user can upload to"
	type = list(string)
}

variable "cloudfront_distribution_ids" {
	description = "list of cloudfront distribution ids that the user can invalidate"
	type = list(string)
}

variable "iam_user_name" {
	description = "name given to IAM user"
	default = "bucket-user"
    type = string
}
