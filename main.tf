resource "aws_lb" "lb" {
  name               = "${var.environment_name}-${terraform.workspace}-lb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = compact(concat([aws_security_group.lb_sg.id], var.security_group_ids))
  subnets            = data.aws_subnets.public_subnets.ids
  idle_timeout       = var.idle_timeout

  dynamic "access_logs" {
    for_each = var.access_log_bucket != null ? [1] : []
    content {
      bucket  = var.access_log_bucket
      prefix  = "elblogs-${var.environment_name}-lb-${terraform.workspace}"
      enabled = true
    }
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "${var.environment_name}-${terraform.workspace}"
  description = "Default load balancer security firewall"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_name}-${terraform.workspace}"
  }
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
  certificate_arn   = data.aws_acm_certificate.cert[0].arn
}

resource "aws_lb_listener" "http_redirect_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
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
