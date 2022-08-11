output "key" {
  value = aws_kms_key.service_key.arn
}

output "alias" {
  value = aws_kms_alias.service_key_alias.arn
}
