resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [
    aws_subnet.private_1.id, 
    aws_subnet.private_2.id]

  tags = {
    Name = "DB Subnet Group"
  }
}

resource "aws_db_instance" "mydb" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  identifier           = "mydatabase"
  username             = "admin"
  password             = "password"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  multi_az             = true
  skip_final_snapshot  = true
}
