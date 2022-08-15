variable "name" {
  type = string
}

variable "stage" {
  type    = string
  default = "dev"
}

variable "key_policy_statements" {
  type = list(map(any))
}
