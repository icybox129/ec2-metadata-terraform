variable "naming_prefix" {
  type = string
}

variable "ec2_sg" {
  type        = set(string)
  description = "Security group settings for EC2 instances"
}

variable "subnets" {
  type        = set(string)
  description = "All the subnets created in the network module"
}

variable "alb_tg_arn" {
  type = string
}