# resource "aws_route53_record" "site" {
#   zone_id = var.dns_zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = aws_lb.main.dns_name
#     zone_id                = aws_lb.main.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_route53_record" "site_wildcard" {
#   zone_id = var.dns_zone_id
#   name    = "${var.project}.${var.domain_name}"
#   type    = "A"

#   alias {
#     name                   = aws_lb.main.dns_name
#     zone_id                = aws_lb.main.zone_id
#     evaluate_target_health = true
#   }
# }