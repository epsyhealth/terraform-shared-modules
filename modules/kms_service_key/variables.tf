variable "name" {
  type = string
}

variable "stage" {
  type    = string
  default = "dev"
}

variable "key_policy_statements" {
  type = list(object({
    sid        = string
    effect     = string
    principals = list(object({
      type        = string
      identifiers = list(string)
    }))
    actions    = list(string)
    resources  = list(string)
    conditions = list(object({
      test     = string
      variable = string
      values   = list(string)
    }))
  }))
}
