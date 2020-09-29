variable "dns_zone_id" {
	description = "Zone id of the Hosted Zone"
}

variable "domain" {
	description = "Domain of the DNS record, e.g. example.com"
}

variable "target_name" {
	description = "Name of the target resource, e.g. http://mybucket.s3-website.eu-central-1.amazonaws.com"
}

variable "target_zone_id" {
	description = "Zone id the target resource"
}
