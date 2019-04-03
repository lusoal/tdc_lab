provider "aws" {
  region = "us-east-2"
}

//Change Bucket name on Terraform
# terraform {
#   backend "s3" {
#     region  = "sa-east-1"
#     bucket  = "__BUCKET_NAME__"
#     key     = "vpc_lab.tfstate"
#     encrypt = true
#   }
# }


module "vpc" {
  source   = "../../../modules/aws/vpc"
  cidr_vpc = "${var.cidr_block}"
  vpc_name = "${var.vpc_name}"
}
