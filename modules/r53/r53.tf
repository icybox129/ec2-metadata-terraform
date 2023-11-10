# # Creates a Reusable Delegation Set. This creates a set of 4 name servers that can be used across multiple hosted zones
# resource "aws_route53_delegation_set" "main" {

# }

# # Creates a public hosted zone using a delegation set
# resource "aws_route53_zone" "primary" {
#   name              = var.domain
#   delegation_set_id = aws_route53_delegation_set.main.id

# }

data "aws_route53_zone" "primary" {
  zone_id = "Z05213995IQENL3CFKUC"
}

resource "aws_route53_record" "apex" {
  zone_id = data.aws_route53_zone.primary.zone_id # Replace with your zone ID
  name    = var.domain                            # Replace with your name/domain/subdomain
  type    = "A"

  alias {
    name                   = var.alb_dns
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# resource "aws_route53_record" "www" {
#   zone_id = aws_route53_zone.primary.zone_id # Replace with your zone ID
#   name    = "www.${var.domain}"              # Replace with your name/domain/subdomain
#   type    = "A"

#   alias {
#     name                   = var.alb_dns
#     zone_id                = var.alb_zone_id
#     evaluate_target_health = true
#   }
# }

# Created a CNAME for www for the SSL cert to apply properly
resource "aws_route53_record" "www-cname" {
  name    = "www"
  records = ["${var.alb_dns}"]
  type    = "CNAME"
  ttl     = 5
  zone_id = data.aws_route53_zone.primary.zone_id
}

# Creates SSL cert
resource "aws_acm_certificate" "icybox_cert" {
  domain_name       = var.domain
  validation_method = "DNS"

  # Allows the cert created above to be applied to any subdomains, such as www.icybox.co.uk
  subject_alternative_names = [
    "*.icybox.co.uk"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_route53_record" "icybox_cert_dns" {
#   allow_overwrite = true
#   name            = tolist(aws_acm_certificate.icybox_cert.domain_validation_options)[0].resource_record_name
#   records         = [tolist(aws_acm_certificate.icybox_cert.domain_validation_options)[0].resource_record_value]
#   type            = tolist(aws_acm_certificate.icybox_cert.domain_validation_options)[0].resource_record_type
#   zone_id         = aws_route53_zone.primary.zone_id
#   ttl             = 60
# }

# resource "aws_acm_certificate_validation" "icybox_cert_validate" {
#   certificate_arn         = aws_acm_certificate.icybox_cert.arn
#   validation_record_fqdns = [aws_route53_record.icybox_cert_dns.fqdn]
# }

resource "aws_route53_record" "cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.icybox_cert.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.primary.zone_id
}

resource "aws_acm_certificate_validation" "validation" {
  timeouts {
    create = "5m"
  }
  certificate_arn         = aws_acm_certificate.icybox_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation_record : record.fqdn]
}