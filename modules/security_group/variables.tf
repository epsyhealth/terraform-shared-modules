variable "ingress_cidr" {
  type    = list(any)
  default = []
}

variable "egress_cidr" {
  type    = list(any)
  default = []
}

variable "vpc_id" {
  type = string
}

variable "ingress_rules" {
  type    = list(any)
  default = [] # Block everything by default - simple, effective and error proof.
}

variable "egress_rules" {
  type    = list(any)
  default = [] # Block everything by default - simple, effective and error proof.
}

variable "name" {
  type    = string
  default = "unnamed security group"
}

variable "description" {
  type    = string
  default = "Created by Terraform"
}

variable "ingress_with_cidr_blocks" {
  type    = list(any)
  default = []
}

variable "egress_with_cidr_blocks" {
  type    = list(any)
  default = []
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "ingress_with_source_security_group_id" {
  type    = list(map(string))
  default = []
}

variable "egress_with_source_security_group_id" {
  type    = list(map(string))
  default = []
}

variable "egress_prefix_list_ids" {
  type    = list(any)
  default = []
}
