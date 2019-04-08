provider "aws" {
  region = "us-east-2"
}

//Change Bucket name on Terraform
terraform {
  backend "s3" {
    region  = "us-east-2"
    bucket  = "tf-state-duarte"
    key     = "application_dr_state.tfstate"
    encrypt = true
  }
}

module "environment" {
  source = "../"
}

#Validar as variaveis dos módulos

module "aws_security_group" {
  source      = "../../../modules/aws/security_group/create_sg"
  sg_name     = "${var.sg_name}"
  vpc_id      = "${module.environment.vpc_id}"
  ips_sg_list = "${var.ips_sg_list}"
}

module "sg_rules_https" {
  source            = "../../../modules/aws/security_group/create_sg_rule"
  port              = 443
  protocol          = "TCP"
  ips_sg_list       = "${var.ips_sg_list}"
  security_group_id = "${module.aws_security_group.id}"
}

module "application_loadbalancer" {
  source          = "../../../modules/aws/alb/aws_lb"
  name            = "${var.elb_name}"
  security_groups = ["${module.aws_security_group.id}"]
  subnets         = "${module.environment.public_subnets}"
  internal        = "${var.internal}"
  idle_timeout    = 300
}

# module "loadbalancer_lister_https" {
#   ssl_certificate   = true
#   source            = "../../../modules/aws/alb/aws_lb_listener"
#   load_balancer_arn = "${module.application_loadbalancer.alb_arn}"
#   certificate_arn   = ""
#   target_group_arn  = "${module.target_group.alb_tg_arn}"
# }

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
  source = "../../../modules/aws/alb/aws_lb_target_group"
  name   = "${var.asg_name}"
  port   = "${var.target_group_port}"
  vpc_id = "${module.environment.vpc_id}"
  path   = "${var.target_group_health_path}"
}

module "aws_security_group_lc" {
  source      = "../../../modules/aws/security_group/create_sg"
  sg_name     = "${var.sg_name}-asg"
  port        = "${var.target_group_port}"
  vpc_id      = "${module.environment.vpc_id}"
  ips_sg_list = "${var.ips_sg_list_lc}"
}
module aws_launch_configuration {
  source          = "../../../modules/aws/launch_config"
  lc_name         = "${var.lc_name}"
  ami_id          = "${data.aws_ami.latest_application.id}"
  instance_type   = "${var.instance_type}"
  path_user_data  = "./user_data.sh"
  security_groups = "${module.aws_security_group_lc.id}"
  iam_role        = "${var.iam_role}"
  key_name        = "${var.key_name}"
}

module auto_scaling_group {
  source            = "../../../modules/aws/asg"
  asg_name          = "${var.asg_name}"
  max_size          = "${var.max_size}"
  min_size          = "${var.min_size}"
  desired_capacity  = "${var.desired_capacity}"
  lc_name           = "${module.aws_launch_configuration.lc_name}"
  subnets_id        = "${module.environment.private_subnets}"
  tag_name          = "${var.tag_name}"
  health_check_type = "ELB"
  target_group_arns = ["${module.target_group.alb_tg_arn}"]

  #Associate ec2 to Load balancer
  tag_team      = "${var.tag_team}"
  associate_elb = "TG"
}

module rds_database {
  source                 = "../../../modules/aws/rds"
  from_snapshot          = "SNAP"
  name                   = "${var.database_name}"
  identifier             = "${var.identifier}"
  allocated_storage      = "${var.allocated_storage}"
  engine                 = "${var.engine}"
  engine_version         = "${var.engine_version}"
  instance_class         = "${var.instance_class}"
  username               = "${var.db_username}"
  password               = "${var.db_password}"
  availability_zone      = "${var.db_availability_zone}"
  vpc_security_group_ids = "${var.vpc_security_group_ids}"

  #Create a Subnet Group
  db_subnet_group_name = "${var.db_subnet_group_name}"
  multi_az             = false

  #Get snapshot from data
  snapshot_identifier = "${data.aws_db_snapshot.latest_prod_snapshot.id}"
  tag_name            = "${var.db_tag_name}"
}
