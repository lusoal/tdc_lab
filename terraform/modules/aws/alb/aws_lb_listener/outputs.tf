output "arn_https" {
  value = "${element(concat(aws_lb_listener.https.*.arn,  list("")), 0)}"
}

output "arn_http" {
  value = "${element(concat(aws_lb_listener.http.*.arn,  list("")), 0)}"
}
