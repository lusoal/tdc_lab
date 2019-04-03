variable "vpc_name" {
  default = "dev"
}

variable "cidr_vpc" {
  default = "172.16.0.0/16"
}

variable "cidr_network_bits" {
  default = "8"
  description = "Cidr of the subnets of the VPC"
}

variable "subnet_count" {
  default = "2"
  description = "2 because inside module we do a loop"
}

variable "azs" {
  default = {
    "us-east-2" = "us-east-2a,us-east-2b,us-east-2c,us-east-2d"
  }
}

variable "region" {
  default = "us-east-2"
}

variable "zone_name" {
  default = "tdc_lab"
}

variable "environment" {
  default = "dev"
  description  = "create a hosted zone private associate with vpc"
}
