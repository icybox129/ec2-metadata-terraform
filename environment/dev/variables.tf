variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "environment" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "lb-checker"
}

variable "domain" {
  type    = string
  default = "icybox.co.uk"
}