output "log_group_arn" {
  value = aws_cloudwatch_log_group.logs.arn
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.logs.name
}
