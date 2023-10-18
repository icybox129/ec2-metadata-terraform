output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "vpc_public_subnet_count" {
  value = var.vpc_public_subnet_count
}

output "vpc_cidr_block" {
  value = var.vpc_cidr_block
}