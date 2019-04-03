variable "name" {}
variable "port" {}

variable "protocol" {
  default = "HTTP"
}

variable "vpc_id" {}

variable "path" {
  default = "status"
}

variable "matcher" {
  default = "200,202"
}

variable "health_check_interval" {
  default = 30
}

variable "healthy_threshold" {
  default = 3
}

variable "unhealthy_threshold" {
  default = 3
}

variable "health_check_timeout" {
  default = 5
}
