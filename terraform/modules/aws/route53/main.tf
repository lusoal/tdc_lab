resource "dns_cname_record" "cname_record" {
  count = "${var.dns_kind == "CNAME" ? 1 : 0}"
  zone     = "${var.zone}"
  name     = "${var.name}"
  cname    = "${var.cname}"
  ttl      = "${var.ttl}"
}
