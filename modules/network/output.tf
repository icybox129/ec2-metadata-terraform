output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "vpc_cidr_block" {
  value = var.vpc_cidr_block
}

output "private_subnet" {
  value = aws_subnet.private_subnet.id
}