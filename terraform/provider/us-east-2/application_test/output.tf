output "rds_address" {
  value = "${module.rds_database.address}"
}

output "alb_dns" {
  value = "${module.application_loadbalancer.dns_name}"
}