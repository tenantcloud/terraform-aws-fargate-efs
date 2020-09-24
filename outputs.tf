output "lb_hostname" {
  value = aws_lb.main.dns_name
}

# output "certificate_arn" {
#   value = aws_acm_certificate.certificate.arn
# }