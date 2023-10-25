variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "environment" {
  type    = string
  default = "dev"
}

variable "naming_prefix" {
  type    = string
  default = "lb-checker"
}

variable "domain" {
  type    = string
  default = "icybox.co.uk"
}