variable "sg_name" {
  default = "my-elb-sg"
}

variable "ips_sg_list" {
  default = ["10.5.0.0/16", "0.0.0.0/0"]
  description = "Sg para o balanceador"
}

variable "ips_sg_list_lc" {
  default = ["10.5.0.0/16"]
}

variable "listener_port" {
  default = 80
}

variable "listener_protocol" {
  default = "HTTP"
}

variable "target_group_port" {
  default     = 8888
  description = "Port of my applicaiton to receive traffic"
}

variable "target_group_health_path" {
  default = "api/health/"
}

variable "elb_name" {
  default = "tdc-lab-lb"
}

# variable "ssl_arn" {
#   default = ""
# }

variable "application_port" {
  default = 8888
}

variable "internal" {
  default = false
}

#Lauch Configuration
variable "lc_name" {
  default = "lc-tdc-applciation-lab-"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "iam_role" {
  default = "arn:aws:iam::618118007154:instance-profile/aws-full-access"
}

variable "key_name" {
  default = "tdclabkey"
}

#Auto Scaling Variables
variable "asg_name" {
  default = "asg-tdc-lab"
}

variable "max_size" {
  default = 5
}

variable "min_size" {
  default = 3
}

variable "desired_capacity" {
  default = 3
}

variable "tag_name" {
  default = "asg-tdc-lab"
}

variable "tag_team" {
  default = "Duate"
}

#Database Variables

variable "identifier" {
  default = "tdc-ab"
}

variable "allocated_storage" {
  default = 20
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.6"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "db_availability_zone" {
  default = "us-east-2a"
}

variable "db_tag_name" {
  default = "tdclabdb"
}

variable "db_subnet_group_name" {
  default = "private_subnet_group"
}

variable "vpc_security_group_ids" {
  default = ["sg-07bdffc34e7525450"]
}

variable "database_name" {
  default = "jazz"
}

variable "db_username" {}

variable "db_password" {}

variable "application_ami_name" {
  default = "MyApplication"
}
