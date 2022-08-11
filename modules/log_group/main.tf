resource "aws_cloudwatch_log_group" "logs" {
  name              = var.name
  kms_key_id        = var.encryption_key_arn
  retention_in_days = 30
}
