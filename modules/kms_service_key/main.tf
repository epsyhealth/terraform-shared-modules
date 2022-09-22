data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

terraform {
  experiments = [module_variable_optional_attrs]
}

locals {
  default_statements = [
    {
      sid       = "Enable IAM User Permissions"
      effect    = "Allow"
      actions   = ["kms:*"]
      resources = ["*"]

      principals = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
        }
      ]
    }
  ]
}


data aws_iam_policy_document "policy" {
  dynamic "statement" {
    for_each = concat(local.default_statements, var.key_policy_statements)
    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions    = statement.value.actions
      resources = statement.value.resources

      dynamic "principals" {
        for_each = coalesce(lookup(statement.value, "principals", []), [])
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = coalesce(lookup(statement.value, "conditions", []), [])
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_kms_key" "service_key" {
  deletion_window_in_days = 14
  multi_region            = true
  policy                  = data.aws_iam_policy_document.policy.json
}

resource "aws_kms_alias" "service_key_alias" {
  target_key_id = aws_kms_key.service_key.arn
  name          = "alias/${var.name}-${var.stage}"
}
