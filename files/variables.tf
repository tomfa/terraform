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
	description = "typically public-read for shared website assets, or private for user uploads"
	default = "private"
}

variable "domain_aliases" {
	description = "e.g. [\"files.mydomain.com\"]. If set, requires a matching certificate_arn."
	default = []
	type = list(string)
}

variable "certificate_arn" {
	description = "ARN of Certificate to use for distribution. Required if domain_aliases is set."
	default = ""
}
