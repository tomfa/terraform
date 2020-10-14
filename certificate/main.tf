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

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
}
