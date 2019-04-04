variable "from_snapshot" {
  description = "Create an instance from a database snapshot"  
}

variable "identifier" {}


variable "allocated_storage" {}

variable "storage_type" {
  default = "gp2"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7"
}

variable "instance_class" {}

variable "name" {}

variable "publicly_accessible" {
  default = false
}

variable "username" {
  default = "default_user"
}

variable "password" {
  default = "default_pass"
}

variable "parameter_group_name" {
  default = "default.mysql5.7"
}

variable "availability_zone" {}

variable "db_subnet_group_name" {}

variable "multi_az" {
  default = false
}

variable "maintenance_window" {
  default = "Sat:01:01-Sat:02:01"
}

variable "backup_window" {
  default = "07:00-07:30"
}

variable "backup_retention_period" {
  default = 5
}

variable "tag_name" {}

variable "snapshot_identifier" {
  description = "The snapshot identifier of the Database instance"
}
