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

variable "firewall_setting" {
  description = "Inbound, outbound and security group attachments to the load balancer"
  type = object({
    inbound = object({
      cidr_ipv4 = optional(list(string))
      cidr_ipv6 = optional(list(string))
    })
    outbound = object({
      cidr_ipv4 = optional(list(string))
      cidr_ipv6 = optional(list(string))
    })
    security_groups = optional(list(string))
  })
  default = null
}
