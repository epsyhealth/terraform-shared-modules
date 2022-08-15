variable "name" {
  type = string
}

variable "stage" {
  type    = string
  default = "dev"
}

variable "key_policy_statements" {
  type = list(object({
    effect     = string
    principals = list(object({
      type        = string
      identifiers = list(string)
    }))
    action     = list(string)
    resource   = list(string)
    conditions = list(object({
      test     = string
      variable = string
      values   = list(string)
    }))
  }))
}
