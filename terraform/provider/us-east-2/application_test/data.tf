data "aws_ami" "latest_application" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["${var.application_ami_name}*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_db_snapshot" "latest_prod_snapshot" {
  db_instance_identifier = "${var.identifier}"
  most_recent            = true
  snapshot_type          = "manual"
}
