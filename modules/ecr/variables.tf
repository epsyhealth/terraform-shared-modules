variable "repository_name" {
  type = "string"
}
variable "accounts" {
  default = {
    "shared"      = "315636072324"
    "playground"  = "772962929486"
    "development" = "693770567656"
    "staging"     = "262533678028"
    "production"  = "500716809157"
  }
}
