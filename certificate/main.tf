provider "aws" {
  region = "us-east-1"  # Required for certificates
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain
  subject_alternative_names = var.alternative_names
  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "example" {
  for_each = var.route53_zone_id != "" && var.validation_method == "DNS" ? aws_acm_certificate.cert.domain_validation_options : {}

  allow_overwrite = true
  name            = each.value.resource_record_name
  records         = [each.value.resource_record_value]
  ttl             = 60
  type            = each.value.resource_record_type
  zone_id         = var.route53_zone_id
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
}


