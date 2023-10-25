data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_launch_template" "ec2_lb_checker" {
  name_prefix            = "ec2-lb-checker"
  image_id               = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type          = "t2.micro"
  user_data              = filebase64("${path.module}/user-data.sh")
  vpc_security_group_ids = var.ec2_sg

  metadata_options {
    http_tokens = "optional"
  }
}