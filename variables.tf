variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-southeast-2"
}

variable "base_domain" {
  type        = string
  description = "Base domain"
}

variable "application_port" {
  type        = number
  description = "Application container port"
}

variable "target_type" {
  type        = string
  description = "Target type for load balancer target group"
  default     = "ip"
}

variable "system_name" {
  type        = string
  description = "System name"
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
  default     = "ELBSecurityPolicy-2016-08"
}
