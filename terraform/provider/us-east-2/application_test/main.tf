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

#Validar as variaveis dos módulos

module "aws_security_group" {
  source      = "../../../../modules/security_group/create_sg"
  sg_name     = "${var.sg_name}"
  vpc_id      = "${var.vpc_id}"
  ips_sg_list = "${var.ips_sg_list}"
}

module "sg_rules_https" {
  source            = "../../../../modules/security_group/create_sg_rule"
  port              = 80
  protocol          = "TCP"
  ips_sg_list       = "${var.ips_sg_list}"
  security_group_id = "${module.aws_security_group.id}"
}

module "application_loadbalancer" {
  source          = "../../../modules/aws/alb/aws_lb"
  name            = "${var.elb_name}"
  security_groups = ["${module.aws_security_group.id}"]
  subnets         = "${module.environment.public_subnets}"
  idle_timeout    = 300
}

module "loadbalancer_lister_https" {
  ssl_certificate   = true
  source            = "../../../modules/aws/alb/aws_lb_listener"
  load_balancer_arn = "${module.application_loadbalancer.alb_arn}"
  certificate_arn   = "${data.aws_acm_certificate.aws_guiabolso.arn}"
  target_group_arn  = "${module.target_group.alb_tg_arn}"
}

module "loadbalancer_lister_http" {
  source            = "../../../modules/aws/alb/aws_lb_listener"
  load_balancer_arn = "${module.application_loadbalancer.alb_arn}"
  target_group_arn  = "${module.target_group.alb_tg_arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"
  ssl_certificate   = ""
  certificate_arn   = ""
}

module "target_group" {
  source                = "../../../modules/aws/alb/aws_lb_target_group"
  name                  = "${var.asg_name}"
  port                  = "${var.target_group_port}"
  vpc_id                = "${data.aws_vpc.vpc.id}"
  path                  = "${var.target_group_health_path}"
  matcher               = "${var.target_group_matcher}"
  health_check_interval = "${var.health_check_interval}"
  healthy_threshold     = "${var.healthy_threshold}"
  unhealthy_threshold   = "${var.unhealthy_threshold}"
  health_check_timeout  = "${var.health_check_timeout}"
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
  source            = "../../../modules/aws/asg"
  asg_name          = "${var.asg_name}"
  max_size          = "${var.max_size}"
  min_size          = "${var.min_size}"
  desired_capacity  = "${var.desired_capacity}"
  lc_name           = "${module.application_lc.name}"
  subnets_id        = "${module.environment.private_subnets}"
  tag_name          = "${var.tag_name}"
  health_check_type = "ELB"
  target_group_arns = ["${module.target_group.alb_tg_arn}"]

  #Associate ec2 to Load balancer
  load_balancer = "${module.load_balancer.name}"
  tag_team      = "${var.tag_team}"
  associate_elb = "TG"
}

#Create Database using Snapshot
#Update DNS Record Set to the new ELB Endpoint
#Update DNS Record Set to the new RDS instance Endpoint

