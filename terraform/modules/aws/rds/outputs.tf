output "arn" {
  value = "${element(concat(aws_db_instance.aws_rds.*.arn, list("")), 0)}"
}

output "id" {
  value = "${element(concat(aws_db_instance.aws_rds.*.id, list("")), 0)}"
}

output "endpoint" {
  value = "${element(concat(aws_db_instance.aws_rds.*.endpoint, list("")), 0)}"
}

output "parameter_id" {
  value = "${aws_db_parameter_group.default.id}"
}