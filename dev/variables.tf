variable "default_tags" {
  type = map(any)
  default = {
    Environment = "Dev"
    Love        = "Emese"
  }
}
