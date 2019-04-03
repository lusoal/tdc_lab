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

module "environment" {
  source = "../"
}

#Create Security Groups for application and for load balancer
module load_balancer {
  source      = "../../../modules/aws/elb"
  elb_name    = "${var.elb_name}"
  subnets_ids = "${module.environment.public_subnets}"
  ssl_arn     = "${var.ssl_arn}"

  #Porta que a aplicação vai responder dentro do servidor
  application_port = "${var.application_port}"
  security_groups  = "${var.security_groups}"
  internal         = "${var.internal}"
  idle_timeout     = 300
}

module application_lc {
  source          = "../../../modules/aws/launch_config"
  lc_name         = "${var.lc_name}"
  ami_id          = "${var.ami_id}"
  instance_type   = "${var.instance_type}"
  path_user_data  = "./user_data.sh"
  security_groups = "${var.asg_security_groups}"
  iam_role        = "${var.iam_role}"
  key_name        = "${var.key_name}"
}

module auto_scaling_group {
  source           = "../../../modules/aws/asg"
  asg_name         = "${var.asg_name}"
  max_size         = "${var.max_size}"
  min_size         = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"
  lc_name          = "${module.application_lc.name}"
  subnets_id       = "${module.environment.private_subnets}"
  tag_name         = "${var.tag_name}"

  #Associate ec2 to Load balancer
  load_balancer = "${module.load_balancer.name}"
  tag_team      = "${var.tag_team}"
  associate_elb = "ELB"
}

#Create Database using Snapshot
#Update DNS Record Set to the new ELB Endpoint
#Update DNS Record Set to the new RDS instance Endpoint