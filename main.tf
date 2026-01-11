#tfsec:ignore:aws-elb-alb-not-public:exp:2026-02-01
resource "aws_lb" "lb" {
  name                       = "${var.environment_name}-${terraform.workspace}-lb"
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = compact(concat([aws_security_group.lb_sg.id], try(coalesce(var.firewall_setting.security_groups, []))))
  subnets                    = data.aws_subnets.subnets.ids
  idle_timeout               = var.idle_timeout
  drop_invalid_header_fields = true

  dynamic "access_logs" {
    for_each = var.access_log_bucket != null ? [1] : []
    content {
      bucket  = var.access_log_bucket
      prefix  = "elblogs-${var.environment_name}-lb-${terraform.workspace}"
      enabled = true
    }
  }

  tags = local.tags
}

resource "aws_security_group" "lb_sg" {
  name        = "${var.environment_name}-${terraform.workspace}"
  description = "Default load balancer security firewall"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, {
    Name = "${var.environment_name}-${terraform.workspace}"
  })
}

resource "aws_vpc_security_group_ingress_rule" "tls_ipv4" {
  for_each          = toset(try(coalesce(var.firewall_setting.inbound.cidr_ipv4, []), []))
  description       = "Ingress rule for TLS traffic - ${each.value}"
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = each.value
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  tags              = local.tags
}

resource "aws_vpc_security_group_ingress_rule" "tls_ipv6" {
  for_each          = toset(try(coalesce(var.firewall_setting.inbound.cidr_ipv6, []), []))
  description       = "Ingress rule for TLS traffic - ${each.value}"
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv6         = each.value
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  tags              = local.tags
}

resource "aws_vpc_security_group_egress_rule" "all_traffic_ipv4" {
  for_each          = toset(try(var.firewall_setting.outbound.cidr_ipv4, []))
  description       = "Egress rule for all traffic - ${each.value}"
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = each.value
  ip_protocol       = "-1"
  tags              = local.tags
}

resource "aws_vpc_security_group_egress_rule" "all_traffic_ipv6" {
  for_each          = toset(try(var.firewall_setting.outbound.cidr_ipv6, []))
  description       = "Egress rule for all traffic - ${each.value}"
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv6         = each.value
  ip_protocol       = "-1"
  tags              = local.tags
}

resource "aws_lb_listener" "listener" {
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "application/json"
      message_body = "Unauthorised"
      status_code  = 401
    }
  }

  protocol          = "HTTPS"
  load_balancer_arn = aws_lb.lb.arn
  port              = 443
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn
  tags              = local.tags
}

resource "aws_route53_record" "record" {
  count   = try(var.endpoint.aws_dns, false) ? 1 : 0
  zone_id = data.aws_route53_zone.zone[0].zone_id
  name    = var.endpoint.value
  type    = "A"

  alias {
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}
