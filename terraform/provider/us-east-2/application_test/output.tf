output "rds_endpoint" {
  value = "${module.rds_database.endpoint}"
}

output "snap_restore" {
  value = "${data.aws_db_snapshot.latest_prod_snapshot.id}"
}
