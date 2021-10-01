variable "redshift_cluster_identifier" {
  default = "general"
}

variable "redshift" {
  type = map(string)
  default = {
    cluster_identifier = "general"
  }
}

variable "connection_name" {
  type = string
  default = "redshift-general"
}

variable "connection_properties" {
  type = map(string)
  default = {
    database = "epsy",
    username = "mydbuser"
  }
}

variable "physical_connection_requirements" {
  type = map(string)
  default = {
    availability_zone = "us-east-1a"
  }
}
