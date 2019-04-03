variable "name" {}

variable "internal" {
  default = true
}

variable "load_balancer_type" {
  default = "application"
}

variable "security_groups" {
  type = "list"
}

variable "subnets" {
  type = "list"
}

variable "enable_deletion_protection" {
  default = false
}

variable "idle_timeout" {
  default = 60
}

variable "weight" {
  default = 0
}

variable "identifier" {
  description = "Used only on weighted records, leave \"\" if not weighted"
  default     = ""
}
