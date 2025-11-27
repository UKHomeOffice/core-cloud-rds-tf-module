output "rds_instance_ids" {
  description = "A map of RDS instance IDs"
  value = merge(
    { for k, v in aws_db_instance.custom_password : k => v.id },
    { for k, v in aws_db_instance.managed_password : k => v.id }
  )
}

output "endpoints" {
  description = "A map of connection endpoints for all RDS instances"
  value = merge(
    { for k, instance in aws_db_instance.custom_password : k => instance.endpoint },
    { for k, instance in aws_db_instance.managed_password : k => instance.endpoint }
  )
}

output "instance_ids" {
  description = "A map of RDS instance IDs"
  value = merge(
    { for k, instance in aws_db_instance.custom_password : k => instance.id },
    { for k, instance in aws_db_instance.managed_password : k => instance.id }
  )
}

output "rds_password_secrets" {
  description = "A map of Secrets Manager ARNs for RDS passwords (only if AWS is NOT managing passwords)"
  value       = { for k, v in aws_secretsmanager_secret.rds_password : k => v.arn if contains(keys(aws_secretsmanager_secret.rds_password), k) }
}

output "security_group_ids" {
  value = { for k, v in aws_security_group.this : k => v.id }
}
