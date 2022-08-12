output "key_arn" {
  value = aws_kms_key.service_key.arn
}

output "alias_arn" {
  value = aws_kms_alias.service_key_alias.arn
}
