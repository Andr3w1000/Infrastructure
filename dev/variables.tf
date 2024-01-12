variable "default_tags" {
  type = map(any)
  default = {
    Environment = "Dev"
    Owner       = "Bandi"
  }
}
