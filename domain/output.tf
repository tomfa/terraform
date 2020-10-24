output "DOMAIN_ZONE_ID" {
  value = aws_route53_zone.domain.zone_id
}

output "DNS_SERVERS" {
  description = "Point your registrar DNS config to point to these IPs"
  value = aws_route53_zone.domain.name_servers
}
