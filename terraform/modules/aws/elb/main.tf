resource "aws_elb" "default_elb" {
  name                        = "${var.elb_name}"
  subnets                     = "${var.subnets_ids}"
  security_groups             = ["${var.security_groups}"]
  internal                    = "${var.internal}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"

  listener {
    instance_port     = "${var.application_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = "${var.application_port}"
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${var.ssl_arn}"
  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 3
    target              = "HTTP:${var.application_port}/health"
    interval            = 30
  }
}
