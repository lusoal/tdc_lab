#Load Balancer Variables
variable "elb_name" {
  default = ""
}

variable "ssl_arn" {
  default = ""
}

variable "application_port" {
  default = ""
}

variable "security_groups" {
  default = [""]
  type    = "list"
}

variable "internal" {
  default = false
}

#Lauch Configuration
variable "lc_name" {
  default = "value"
}

variable "ami_id" {
  default = "value"
}

variable "instance_type" {
  default = "value"
}

variable "asg_security_groups" {
  default = [""]
  type    = "list"
}

variable "iam_role" {
  default = ""
}

variable "key_name" {
  default = ""
}

#Auto Scaling Variables
variable "asg_name" {
  default = "value"
}

variable "max_size" {
  default = "value"
}

variable "min_size" {
  default = "value"
}

variable "desired_capacity" {
  default = "value"
}

variable "tag_name" {
  default = "value"
}

variable "tag_team" {
  default = "value"
}
