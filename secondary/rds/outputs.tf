output "postgres_endpoint" {
    value = aws_db_instance.secondary_rds.endpoint
}