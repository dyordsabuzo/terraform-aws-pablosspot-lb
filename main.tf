resource "aws_lb" "lb" {
  name               = "${var.system_name}-lb-${terraform.workspace}"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = data.aws_subnet_ids.subnets.ids
}

resource "aws_security_group" "lb_sg" {
  name        = "${var.system_name}-${terraform.workspace}"
  description = "Load balancer security firewall"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "${var.system_name}-${terraform.workspace}"
  }
}

resource "aws_default_vpc" "default" {
  lifecycle {
    ignore_changes = [
      tags
    ]
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
  certificate_arn   = data.aws_acm_certificate.cert.arn
}

resource "aws_route53_record" "record" {
  for_each = toset(var.endpoints)
  zone_id  = data.aws_route53_zone.zone.zone_id
  name     = each.key
  type     = "A"

  alias {
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_lb_listener" "http_listner" {
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
