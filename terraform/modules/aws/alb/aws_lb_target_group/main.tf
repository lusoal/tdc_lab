resource "aws_lb_target_group" "tg" {
  name     = "${var.name}"
  port     = "${var.port}"
  protocol = "${var.protocol}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    interval            = "${var.health_check_interval}"
    protocol            = "${var.protocol}"
    path                = "/${var.path}"
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.health_check_timeout}"
    matcher             = "${var.matcher}"
  }
}
