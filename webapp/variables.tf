variable "aws_region" {
	description = "e.g. eu-central-1"
}
variable "bucket_name" {
	description = "e.g. your-bucket-name"
}
variable "domain_aliases" {
	description = "e.g. [\"www.mybucket.com\"]. Requires a matching certificate_arn"
	default = []
	type = list(string)
}
variable "error_path" {
	description = "Path to be served when bucket file is missing"
	default = "/index.html"
}
variable "error_code" {
	description = "HTTP response code when bucket file is missing"
	default = "200"
}

variable "certificate_arn" {
	description = "ARN of Certificate to use for distribution"
	default = ""
}
