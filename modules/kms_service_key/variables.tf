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
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })))
    actions    = optional(list(string))
    resources  = optional(list(string))
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })))
  }))
}
