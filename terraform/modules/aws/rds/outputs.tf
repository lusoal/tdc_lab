output "arn" {
  value = "${aws_db_instance.aws_rds.arn}"
}

output "id" {
  value = "${aws_db_instance.aws_rds.id}"
}

output "endpoint" {
  value = "${aws_db_instance.aws_rds.endpoint}"
}

output "parameter_id" {
  value = "${aws_db_parameter_group.default.id}"
}
