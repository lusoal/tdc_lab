resource "aws_lb_listener" "https" {
  count             = "${var.ssl_certificate != "" ? 1 : 0}"
  load_balancer_arn = "${var.load_balancer_arn}"
  port              = "${var.port}"
  protocol          = "${var.protocol}"
  certificate_arn   = "${var.certificate_arn}"

  default_action {
    type             = "${var.type}"
    target_group_arn = "${var.target_group_arn}"
  }
}

resource "aws_lb_listener" "http" {
  count             = "${var.ssl_certificate == "" ? 1 : 0}"
  load_balancer_arn = "${var.load_balancer_arn}"
  port              = "${var.port}"
  protocol          = "${var.protocol}"

  default_action {
    type             = "${var.type}"
    target_group_arn = "${var.target_group_arn}"
  }
}
