resource "aws_db_instance" "aws_rds" {
  count                     = "${var.from_snapshot == "NO_SNAP" ? 1 : 0}"
  name                      = "${var.name}"
  identifier                = "${var.identifier}"
  allocated_storage         = "${var.allocated_storage}"
  storage_type              = "${var.storage_type}"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine_version}"
  instance_class            = "${var.instance_class}"
  username                  = "${var.username}"
  password                  = "${var.password}"
  parameter_group_name      = "${aws_db_parameter_group.default.name}"
  availability_zone         = "${var.availability_zone}"
  db_subnet_group_name      = "${var.db_subnet_group_name}"
  multi_az                  = "${var.multi_az}"
  maintenance_window        = "${var.maintenance_window}"
  backup_window             = "${var.backup_window}"
  publicly_accessible       = "${var.publicly_accessible}"
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "${var.identifier}-finalsnap"
  vpc_security_group_ids    = "${var.vpc_security_group_ids}"

  tags {
    Name = "${var.tag_name}"
  }

  depends_on = ["aws_db_parameter_group.default"]
}

resource "aws_db_instance" "aws_rds_snapshot" {
  count                     = "${var.from_snapshot == "SNAP" ? 1 : 0}"
  name                      = "${var.name}"
  identifier                = "${var.identifier}"
  allocated_storage         = "${var.allocated_storage}"
  storage_type              = "${var.storage_type}"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine_version}"
  instance_class            = "${var.instance_class}"
  username                  = "${var.username}"
  password                  = "${var.password}"
  parameter_group_name      = "${aws_db_parameter_group.default.name}"
  availability_zone         = "${var.availability_zone}"
  db_subnet_group_name      = "${var.db_subnet_group_name}"
  multi_az                  = "${var.multi_az}"
  maintenance_window        = "${var.maintenance_window}"
  backup_window             = "${var.backup_window}"
  publicly_accessible       = "${var.publicly_accessible}"
  snapshot_identifier       = "${var.snapshot_identifier}"
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "${var.identifier}-finalsnap"
  vpc_security_group_ids    = "${var.vpc_security_group_ids}"

  tags {
    Name = "${var.tag_name}"
  }

  depends_on = ["aws_db_parameter_group.default"]
}

//Always create a parameter group for the RDS instance

resource "aws_db_parameter_group" "default" {
  name   = "${var.name}-parameter-group"
  family = "${var.engine}${var.engine_version}"

  //Those paramters are Default
  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
