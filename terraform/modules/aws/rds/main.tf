resource "aws_db_instance" "aws_rds" {
  count                = "${var.from_snapshot == true ? 0 : 1}"
  name                 = "${var.name}"
  allocated_storage    = "${var.allocated_storage}"
  storage_type         = "${var.storage_type}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  instance_class       = "${var.instance_class}"
  username             = "${var.username}"
  password             = "${var.password}"
  parameter_group_name = "${aws_db_parameter_group.default.name}"
  availability_zone    = "${var.availability_zone}"
  db_subnet_group_name = "${var.db_subnet_group_name}"
  multi_az             = "${var.multi_az}"
  maintenance_window   = "${var.maintenance_window}"
  backup_window        = "${var.backup_window}"
  publicly_accessible  = "${var.publicly_accessible}"

  tags {
    Name          = "${var.tag_name}"
    Team          = "${var.team_name}"
    Application   = "${var.application}"
    workload-type = "${var.workload_type}"
  }

  depends_on = ["aws_db_parameter_group.default"]
}

resource "aws_db_instance" "aws_rds_snapshot" {
  count                = "${var.from_snapshot == true ? 1 : 0}"
  name                 = "${var.name}"
  allocated_storage    = "${var.allocated_storage}"
  storage_type         = "${var.storage_type}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  instance_class       = "${var.instance_class}"
  username             = "${var.username}"
  password             = "${var.password}"
  parameter_group_name = "${aws_db_parameter_group.default.name}"
  availability_zone    = "${var.availability_zone}"
  db_subnet_group_name = "${var.db_subnet_group_name}"
  multi_az             = "${var.multi_az}"
  maintenance_window   = "${var.maintenance_window}"
  backup_window        = "${var.backup_window}"
  publicly_accessible  = "${var.publicly_accessible}"
  snapshot_identifier  = "${var.snapshot_identifier}"

  tags {
    Name          = "${var.tag_name}"
    Team          = "${var.team_name}"
    Application   = "${var.application}"
    workload-type = "${var.workload_type}"
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
