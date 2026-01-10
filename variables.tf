variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-southeast-2"
}

variable "environment_name" {
  type        = string
  description = "Environment name"
}

variable "vpc_id" {
  type        = string
  description = "ID of vpc where resources will be created"
}

variable "internal" {
  type        = bool
  description = "Flag to indicate if load balancer is internal"
  default     = false
}

variable "load_balancer_type" {
  type        = string
  description = "Type of load balancer"
  default     = "application"
}

variable "ssl_policy" {
  type        = string
  description = "SSL policy for the load balancer listener"
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

variable "endpoint" {
  description = "Endpoint that will expose the load balancer"
  type = object({
    value       = string
    base_domain = string
    aws_dns     = optional(bool)
  })
}

variable "idle_timeout" {
  description = "Load balancer idle timeout"
  type        = number
  default     = 60
}

variable "access_log_bucket" {
  description = "S3 bucket to store access logs"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security groups to attach to the lb"
  type        = list(string)
  default     = []
}

variable "certificate_arn" {
  description = "AWS ACM arn to attach to load balancer"
  type        = string
}

variable "ingress_cidr_ipv4_list" {
  description = "List of IPV4 CIDR blocks where LB ingress is allowed"
  type        = list(string)
  default     = []
}

variable "ingress_cidr_ipv6_list" {
  description = "List of IPV6 CIDR blocks where LB ingress is allowed"
  type        = list(string)
  default     = []
}

variable "egress_cidr_ipv4_list" {
  description = "List of IPV4 CIDR blocks where LB egress is allowed"
  type        = list(string)
  default     = []
}

variable "egress_cidr_ipv6_list" {
  description = "List of IPV6 CIDR blocks where LB egress is allowed"
  type        = list(string)
  default     = []
}
