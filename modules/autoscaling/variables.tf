variable "min_capacity" {
  type    = number
  default = 1
}

variable "max_capacity" {
  type    = number
  default = 2
}

variable "resource_id" {
  type = string
}

variable "ecs_cluster" {
  type = string
}

variable "service_name" {
  type = string
}
