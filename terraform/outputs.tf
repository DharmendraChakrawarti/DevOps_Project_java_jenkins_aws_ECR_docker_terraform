output "ec2_public_ip" {
  value = aws_instance.student_app.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.student_db.endpoint
}