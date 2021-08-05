/* フロントエンド側SSL証明書 */
resource "aws_acm_certificate" "codecraft-frontend-acm" {
  domain_name               = aws_route53_record.codecraft-zone-record.name
  subject_alternative_names = ["*.codecraftapp.com",]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "codecraftapp.com"
  }
}
/* バックエンド側SSL証明書 */
resource "aws_acm_certificate" "codecraft-backend-acm" {
  domain_name               = aws_route53_record.codecraft-host-zone-record.name
  subject_alternative_names = []
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "codecraft.net"
  }
}

/* SSL検証 */
resource "aws_route53_record" "codecraft-certificate" {
  name    = tolist(aws_acm_certificate.codecraft-backend-acm.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.codecraft-backend-acm.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.codecraft-backend-acm.domain_validation_options)[0].resource_record_value]
  zone_id = aws_route53_zone.codecraft-host-zone.id
  ttl     = 60
}

/* 検証待機 */
resource "aws_acm_certificate_validation" "codecraft-backend-acm" {
  certificate_arn         = aws_acm_certificate.codecraft-backend-acm.arn
  validation_record_fqdns = [aws_route53_record.codecraft-certificate.fqdn]
}