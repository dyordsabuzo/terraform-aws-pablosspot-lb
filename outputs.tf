output "target_group_arn" {
  value = aws_lb_target_group.target.arn
}

output "lb_listener_arn" {
  value = aws_lb_listener.listener.arn
}
