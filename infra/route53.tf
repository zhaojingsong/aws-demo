data "aws_route53_zone" "jingsong_zone"{
  name = var.domain_name
}

resource "aws_acm_certificate" "jingsong_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  provider = aws.virginia

  tags = {
    Name = "jingsong-cert"
  }
}
resource "aws_route53_record" "jingsong_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.jingsong_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.jingsong_zone.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}