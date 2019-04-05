variable "dns_kind" {}

variable "zone" {}

variable "name" {}

variable "cname" {
  default = "example.com"
}

variable "ttl" {
  default = 300
}
