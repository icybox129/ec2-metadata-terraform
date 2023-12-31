data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/python/lambda_function.py"
  output_path = "${path.module}/python/test.zip"
}

resource "aws_lambda_function" "test_lambda_function" {
  function_name    = "lambdaTest"
  filename         = "${path.module}/python/test.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role             = aws_iam_role.lambda_exec.arn
  runtime          = "python3.9"
  handler          = "lambda_function.lambda_handler"
  timeout          = 10

  vpc_config {
    subnet_ids         = [var.private_subnet]
    security_group_ids = var.ec2_sg
  }

  environment {
    variables = {
      SECRET_NAME = var.test_secret
    }
  }
}
