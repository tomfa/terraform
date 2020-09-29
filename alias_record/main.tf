provider "aws" {}

resource "aws_route53_record" "domain" {
  name    = var.domain
  zone_id = var.dns_zone_id
  type    = "A"

  alias {
    name                   = var.target_name
    zone_id                = var.target_zone_id
    evaluate_target_health = true
  }
}

