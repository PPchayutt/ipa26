variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Short name used as a prefix for all resource names"
  default     = "ipa-lab02"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance size"
  default     = "t3.micro"
}

variable "instance_count" {
  type        = number
  description = "How many web servers to create"
  default     = 1
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable detailed CloudWatch monitoring"
  default     = false
}

variable "allowed_http_cidrs" {
  type        = list(string)
  description = "CIDR blocks permitted to reach port 80"
  default     = ["0.0.0.0/0"]
}

variable "extra_tags" {
  type        = map(string)
  description = "Additional tags applied to every resource"
  default     = {}
}
