resource "aws_kms_key" "service_key" {
  deletion_window_in_days = 14
  multi_region            = true
}

resource "aws_kms_alias" "service_key_alias" {
  target_key_id = aws_kms_key.service_key.arn
  name          = "alias/${var.name}-${var.stage}"
}
