data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    role = var.internal ? "private" : "public"
  }
}

data "aws_route53_zone" "zone" {
  count = try(var.endpoint.aws_dns, false) ? 1 : 0
  name  = var.endpoint.base_domain
}
