variable "load_balancer_arn" {}

variable "port" {
  default = 443
}

variable "protocol" {
  default = "HTTPS"
}

variable "ssl_certificate" {}

variable "certificate_arn" {}

variable "type" {
  default = "forward"
}

variable "target_group_arn" {}
