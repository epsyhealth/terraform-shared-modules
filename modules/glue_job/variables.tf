variable "project_name" {
  type = string
}

variable "name" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "glue_version" {
  type    = string
  default = "2.0"
}

variable "python_version" {
  type    = string
  default = "3"
}

variable "script_location" {
  type = string
}

variable "job_language" {
  type    = string
  default = "python"
}

variable "temp_dir" {
  type = string
}

variable "bookmark_option" {
  type    = string
  default = "job-bookmark-enable"
}

variable "connections" {
  type = list(any)
}

variable "schedule" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(any)
  default = null
}

variable "worker_type" {
  type    = string
  default = "Standard"
}

variable "number_of_workers" {
  type    = number
  default = 2
}
