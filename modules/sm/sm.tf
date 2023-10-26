resource "aws_secretsmanager_secret" "test_secret" {
  name = "${var.naming_prefix}-test-secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "test_secret" {
  secret_id = aws_secretsmanager_secret.test_secret.id
  secret_string = <<EOF
  {
    "secret-password": "created-in-terraform",
  }
EOF
}