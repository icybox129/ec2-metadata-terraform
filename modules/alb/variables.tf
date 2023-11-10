variable "naming_prefix" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID from network module"
}

variable "subnets" {
  type        = set(string)
  description = "All the subnets created in the network module"
}

variable "alb_sg" {
  type        = set(string)
  description = "Security group settings for ALB"
}

variable "ec2_sg" {
  type        = set(string)
  description = "Security group settings for EC2 instances"
}

variable "icybox_cert_arn" {
  type = string
}