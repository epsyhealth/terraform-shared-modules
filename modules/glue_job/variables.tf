variable "name" {
  type    = string
  default = "my glue job"
}

variable "role_arn" {
  type = string
}

variable "glue_version" {
  type    = string
  default = "2.0"
}

variable "python_version" {
  type = string
}

variable "script_location" {
  type = string
}

variable "job-language" {
  type = string
}

variable "TempDir" {
  type = string
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
