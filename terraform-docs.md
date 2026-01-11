## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.28.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.28.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http_redirect_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.lb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.all_traffic_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.all_traffic_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.tls_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.tls_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnets.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log_bucket"></a> [access\_log\_bucket](#input\_access\_log\_bucket) | S3 bucket to store access logs | `string` | `null` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | AWS ACM arn to attach to load balancer | `string` | n/a | yes |
| <a name="input_egress_cidr_ipv4_list"></a> [egress\_cidr\_ipv4\_list](#input\_egress\_cidr\_ipv4\_list) | List of IPV4 CIDR blocks where LB egress is allowed | `list(string)` | `[]` | no |
| <a name="input_egress_cidr_ipv6_list"></a> [egress\_cidr\_ipv6\_list](#input\_egress\_cidr\_ipv6\_list) | List of IPV6 CIDR blocks where LB egress is allowed | `list(string)` | `[]` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Endpoint that will expose the load balancer | <pre>object({<br/>    value       = string<br/>    base_domain = string<br/>    aws_dns     = optional(bool)<br/>  })</pre> | n/a | yes |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Environment name | `string` | n/a | yes |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | Load balancer idle timeout | `number` | `60` | no |
| <a name="input_ingress_cidr_ipv4_list"></a> [ingress\_cidr\_ipv4\_list](#input\_ingress\_cidr\_ipv4\_list) | List of IPV4 CIDR blocks where LB ingress is allowed | `list(string)` | `[]` | no |
| <a name="input_ingress_cidr_ipv6_list"></a> [ingress\_cidr\_ipv6\_list](#input\_ingress\_cidr\_ipv6\_list) | List of IPV6 CIDR blocks where LB ingress is allowed | `list(string)` | `[]` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Flag to indicate if load balancer is internal | `bool` | `false` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | Type of load balancer | `string` | `"application"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to create resources in | `string` | `"ap-southeast-2"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security groups to attach to the lb | `list(string)` | `[]` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | SSL policy for the load balancer listener | `string` | `"ELBSecurityPolicy-TLS13-1-2-2021-06"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of vpc where resources will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_dns"></a> [lb\_dns](#output\_lb\_dns) | Load balancer dns name |
| <a name="output_lb_listener_arn"></a> [lb\_listener\_arn](#output\_lb\_listener\_arn) | Load balancer listener arn |
