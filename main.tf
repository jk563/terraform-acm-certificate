resource "aws_acm_certificate" "subdomain" {
  domain_name       = var.fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "subdomain_cert_validation" {
  count = length(aws_acm_certificate.subdomain.domain_validation_options)

  name            = element(aws_acm_certificate.subdomain.domain_validation_options.*.resource_record_name, count.index)
  type            = element(aws_acm_certificate.subdomain.domain_validation_options.*.resource_record_type, count.index)
  zone_id         = var.hosted_zone_id
  records         = [element(aws_acm_certificate.subdomain.domain_validation_options.*.resource_record_value, count.index)]
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "subdomain" {
  certificate_arn         = aws_acm_certificate.subdomain.arn
  validation_record_fqdns = aws_route53_record.subdomain_cert_validation.*.fqdn
}

