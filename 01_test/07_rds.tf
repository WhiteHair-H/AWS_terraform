# 21_rds

resource "aws_db_instance" "jinwoo_mydb" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t2.micro"
  name                    = "test"
  identifier              = "test"
  username                = "admin"
  password                = "It12345!"
  parameter_group_name    = "default.mysql8.0"
  availability_zone       = "${var.region}${var.ava[0]}"
  db_subnet_group_name    = aws_db_subnet_group.jinwoo_dbsn.id
  vpc_security_group_ids  = [aws_security_group.jinwoo-sg.id]
  skip_final_snapshot     = true
  tags = {
      Name = "${var.name}-mydb"
  }
}

resource "aws_db_subnet_group" "jinwoo_dbsn" {
  name  =   "jinwoo-dbsb-group"
  subnet_ids = [aws_subnet.jinwoo-pridb[0].id,aws_subnet.jinwoo-pridb[1].id]
  tags = {
      Name = "jinwoo-dbsb-group"
  }
}