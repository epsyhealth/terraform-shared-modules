variable "ingress_cidr" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "egress_cidr" {
  type    = list(any)
  default = ["0.0.0.0/0"]
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
  default = ["all-all"] # By default we don't restrict any outbound connections
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
