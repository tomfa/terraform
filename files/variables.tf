variable "aws_region" {
	description = "e.g. eu-north-1, us-east-1"
}

variable "cors_origins" {
	description = "e.g. [\"www.mybucket.com\"] or [\"*\"]. Required for web page to interact with S3 bucket. By default allows any URL"
	default = ["*"]
	type = list(string)
}

variable "bucket_name" {
	description = "e.g. your-bucket-name"
}

variable "acl" {
	description = "typically private or public-read"
}
