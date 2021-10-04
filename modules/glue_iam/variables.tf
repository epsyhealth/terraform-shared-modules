variable "name" {
  type = string
}

variable "s3_buckets" {
  type        = list(string)
  default     = []
  description = "List of S3 ARNs to which role should have an access to."
}
