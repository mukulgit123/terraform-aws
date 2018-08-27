resource "aws_db_instance" "drupal_rds" {
  allocated_storage    = "${var.rds_disk_size}"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  multi_az	       = "true"
  instance_class       = "${var.db_instance_type}"
  name                 = "${var.drupal_db}"
  username             = "${var.drupal_user}"
  password             = "${var.drupal_pass}"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = "${aws_db_subnet_group.rds_dbsubnet_group.id}"
}

resource "aws_db_subnet_group" "rds_dbsubnet_group" {
  name                 = "rds_dbsubnet_group"
  subnet_ids   	       = ["${aws_subnet.us-east-1a-private.id}"]
  
  tags {
   Name = "DB Subnet Group"
   Environment = "pci_dss_poc"
   }
}
