output "lb_listener_arn" {
  value       = aws_lb_listener.listener.arn
  description = "Load balancer listener arn"
}

output "lb_dns" {
  value       = aws_lb.lb.dns_name
  description = "Load balancer dns name"
}

output "security_group_id" {
  value       = aws_security_group.lb_sg.id
  description = "ID of the load balancer security group"
}

output "lb_arn" {
  value       = aws_lb.lb.arn
  description = "ARN of the load balancer"
}

output "subnet_ids" {
  value       = data.aws_subnets.subnets.ids
  description = "List of subnet ids selected for the load balancer"
}
