variable "elb_name" {}

variable "subnets_ids" {
  default = []
}

variable "ssl_arn" {}

variable "application_port" {}

variable "security_groups" {
  default = []
}

variable "internal" {}

variable "idle_timeout" {}

variable "connection_draining" {
  default = false
}

variable "connection_draining_timeout" {
  default = 300
}
