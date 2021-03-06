variable "domain" {
	description = "Domain name for the certificate, e.g. example.com"
}

variable "alternative_names" {
	description = "Alternative names for the domain. Wildcards allowed, e.g. *.example.com"
	default = []
	type = list(string)
}

variable "validation_method" {
	description = "How AWS should validate ownership, Email will require manual renewals. DNS recommended."
	default = "DNS"
}

variable "route53_zone_id" {
	description = "If specified along with validation method being DNS, the route53 zone id will be used to set up DNS pointers to validate the certificates"
	default = ""
	type = string
}
