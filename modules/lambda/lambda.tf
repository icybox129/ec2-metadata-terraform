data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/python/lambda_function.py"
  output_path = "test.zip"
}

resource "aws_lambda_function" "test_lambda_function" {
  function_name    = "lambdaTest"
  filename         = "test.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.9"
  handler          = "lambda_function.lambda_handler"
  timeout          = 10

  vpc_config {
    subnet_ids         = var.subnets
    security_group_ids = var.ec2_sg
  }
}