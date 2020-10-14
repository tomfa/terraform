output "CERTIFICATE_ARN" {
	value = aws_acm_certificate_validation.cert.certificate_arn
}
