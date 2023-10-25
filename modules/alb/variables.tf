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

variable "instance_type" {
  type        = string
  description = "Type for EC2 Instance"
  default     = "t2.micro"
}

variable "instance_count" {
  type        = number
  description = "Number of instances to create"
  default     = 2
}

variable "vpc_public_subnet_count" {
  type        = number
  description = "Number of public subnets"
}

variable "ec2_sg" {
  type        = set(string)
  description = "Security group settings for EC2 instances"
}

variable "icybox_cert_arn" {
  type = string
}