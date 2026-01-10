data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    role = "public"
  }
}

data "aws_acm_certificate" "cert" {
  domain      = var.endpoint.base_domain
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "zone" {
  count = try(var.endpoint.aws_dns, false) ? 1 : 0
  name  = var.endpoint.base_domain
}
