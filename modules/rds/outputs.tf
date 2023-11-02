output "db_security_group_id" {
  description = "ID of Security Group, membership of which grants routing access to the Redis cluster"
  value       = aws_security_group.rds_sg.id
}

# output "db_url_ssm_parameter_arn" {
#   description = "ARN of the SSM paramter which contains the DB Connection URL"
#   value       = [for db_url in var.rds_instances : aws_ssm_parameter.db_url[db_url].arn]
# }

output "rds_db_endpoint" {
  description = "Endpoint to which to connect for access to this database"
  value       = aws_db_instance.db.endpoint
}

output "read_db_url_ssm_policy_document_json" {
  description = "JSON policy doc allowing read access to the DB Connection URL parameter in SSM"
  value       = data.aws_iam_policy_document.read_db_url_ssm.json
}