resource "aws_lb_listener_rule" "static" {
  count        = "${var.conditions == true ? 0 : 1}"
  listener_arn = "${var.listener_arn}"
  priority     = "${var.priority}"

  action {
    type             = "${var.type}"
    target_group_arn = "${var.target_group_arn}"
  }
}

resource "aws_lb_listener_rule" "with_rule" {
  count        = "${var.conditions == true ? 1 : 0}"
  listener_arn = "${var.listener_arn}"
  priority     = "${var.priority}"

  action {
    type             = "${var.type}"
    target_group_arn = "${var.target_group_arn}"
  }

  condition {
    field  = "${var.field}"
    values = ["${var.values}"]
  }
}
