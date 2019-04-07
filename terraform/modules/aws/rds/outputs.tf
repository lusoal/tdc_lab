# output "arn" {
#   value = "${element(concat(aws_db_instance.aws_rds.*.arn, list("")), 0)}"
# }

# output "id" {
#   value = "${element(concat(aws_db_instance.aws_rds.*.id, list("")), 0)}"
# }

# output "address" {
#   value = "${element(concat(aws_db_instance.aws_rds.*.address, list("")), 0)}"
# }

output "arn" {
  value = "${aws_db_instance.aws_rds_snapshot.arn}"
}

output "id" {
  value = "${aws_db_instance.aws_rds_snapshot.id}"
}

output "address" {
  value = "${aws_db_instance.aws_rds_snapshot.address}"
}

output "parameter_id" {
  value = "${aws_db_parameter_group.default.id}"
}