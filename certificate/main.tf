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
   for_each = var.route53_zone_id == "" || var.validation_method != "DNS" ? {} : {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.route53_zone_id
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
}


