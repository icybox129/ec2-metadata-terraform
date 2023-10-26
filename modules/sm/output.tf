output "test_secret" {
  value = aws_secretsmanager_secret.test_secret.id
}