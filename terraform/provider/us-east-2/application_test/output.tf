output "rds_endpoint" {
  value = "${module.rds_database.endpoint}"
}

output "snap_restore" {
  value = "${data.aws_db_snapshot.latest_prod_snapshot.id}"
}

output "alb_dns" {
  value = "${module.application_loadbalancer.dns_name}"
}
