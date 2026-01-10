output "lb_listener_arn" {
  value       = aws_lb_listener.listener.arn
  description = "Load balancer listener arn"
}

output "lb_dns" {
  value       = aws_lb.lb.dns_name
  description = "Load balancer dns name"
}
