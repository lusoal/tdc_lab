output "alb_arn" {
  value = "${aws_lb.lb.arn}"
}

output "dns_name" {
  value = "${aws_lb.lb.dns_name}"
}
