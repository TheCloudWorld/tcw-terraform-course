resource "aws_db_instance" "db_instance" {
  engine                   = var.engine_name
  name                     = var.db_name
  username                 = var.user_name
  password                 = var.pass
  skip_final_snapshot      = var.skip_finalSnapshot
  db_subnet_group_name     = aws_db_subnet_group.db_sub_group.id
  delete_automated_backups = var.delete_automated_backup
  multi_az                 = var.multi_az_deployment
  publicly_accessible      = var.public_access
  vpc_security_group_ids   = [data.aws_security_group.tcw_sg.id]
  instance_class           = var.instance_class
  allocated_storage        = 20
}
