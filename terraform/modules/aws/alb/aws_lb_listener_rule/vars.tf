variable "listener_arn" {}

variable "priority" {
  default = 100
}

variable "type" {
  default = "forward"
}

variable "target_group_arn" {}

variable "field" {
  default = false
}

variable "values" {
  default = false
}

variable conditions {}
