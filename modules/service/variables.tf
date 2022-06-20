variable "cluster_id" {
  type = string
}

variable "name" {
  type = string
}

variable "enable_execute_command" {
  type    = bool
  default = false
}

variable "task_definition" {
  type = string
}

variable "security_groups" {
  type = list(any)
}

variable "desired_count" {
  type    = number
  default = 1
}


variable "load_balancer" {
  type    = list(any)
  default = []
}

variable "service_registries" {
  type    = list(any)
  default = []
}
