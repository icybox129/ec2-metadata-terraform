# data "aws_ssm_parameter" "amzn2_linux" {
#   name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
# }

# # INSTANCES #
# resource "aws_instance" "ec2" {
#   count = var.instance_count
#   ami           = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
#   # ami           = "ami-067d1e60475437da2"
#   instance_type = var.instance_type
#   # subnet_id = var.subnets[(count.index % var.vpc_public_subnet_count)].id
#   subnet_id              = element(var.subnets.*, count.index)
#   vpc_security_group_ids = var.ec2_sg
#   user_data              = file("${path.module}/user-data.sh")

#   metadata_options {
#     http_tokens = "optional"
#   }

#   tags = {
#     Name = "${var.naming_prefix}-ec2-${count.index}"
#   }
# }