output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "access_key" {
  value = aws_iam_access_key.ppg_app_user_access_key.id
}

output "secret_key" {
  value = aws_iam_access_key.ppg_app_user_access_key.secret
  sensitive = true
}