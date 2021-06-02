variable "name" {
  type = string
}

variable "cpu" {
  type    = number
  default = 20
}

variable "memory" {
  type    = number
  default = 128
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "workspace" {
  type = string
}

variable "image" {
  type = string
}

variable "ports" {
  type = list(object({
    container = number
    host      = number
    proto     = string
    })
  )
  default = []
}

variable "entrypoint" {
  type    = list(any)
  default = null
}

variable "env" {
  type = string
}

variable "awslogs_group" {
  type = string
}

variable "awslogs_region" {
  type = string
}

variable "command" {
  type    = list(any)
  default = null
}

variable "environment" {
  type    = list(object({ name = string, value = any }))
  default = []
}

variable "execution_role_arn" {
  type    = string
  default = "EcsTaskExecution-ng"
}

variable "task_role_arn" {
  type    = string
}

variable "network_mode" {
  type    = string
  default = "awsvpc"
}
