output "lb_listener_arn" {
  value = aws_lb_listener.listener.arn
}

output "lb_dns" {
  value = aws_lb.lb.dns_name
}
