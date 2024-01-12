variable "global_default_tags" {
  type = map(any)
  default = {
    Project = "ETL"
    Owner   = "andras.szuda@outlook.com"
  }
}
