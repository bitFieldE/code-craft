#　バックエンド用
resource "aws_route53_zone" "codecraft-host-zone" {
  name    = "codecraftapp.net"
  comment = "codecraftapp.net host zone"
}

resource "aws_route53_record" "codecraft-host-zone-record" {
  zone_id = aws_route53_zone.codecraft-host-zone.zone_id
  name    = aws_route53_zone.codecraft-host-zone.name
  type    = "A"

  alias {
    name                   = aws_lb.codecraft-backend-alb.dns_name
    zone_id                = aws_lb.codecraft-backend-alb.zone_id
    evaluate_target_health = true
  }
}


# フロントエンド用
resource "aws_route53_zone" "codecraft-zone" {
  name = "codecraftapp.com"
  tags = {
    "codecraft" = "codecraftapp.com" 
  }
}

resource "aws_route53_record" "codecraft-zone-record" {
  zone_id = aws_route53_zone.codecraft-zone.id
  name = aws_route53_zone.codecraft-zone.name
  type = "A"

  alias {
    name = aws_lb.codecraft-alb.dns_name
    zone_id = aws_lb.codecraft-alb.zone_id
    evaluate_target_health = true
  }
}