output "CERTIFICATE_ARN" {
	value = aws_acm_certificate_validation.cert.certificate_arn
}

output "CERTIFICATE_DNS_VALIDATION_POINTERS" {
	description = "If you do NOT use AWS for DNS, add these pointers to your existing DNS server to validate the certificate."
	value = aws_acm_certificate.cert.domain_validation_options
}
