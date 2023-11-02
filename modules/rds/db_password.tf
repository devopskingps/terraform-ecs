resource "random_password" "db" {
  length  = 32
  special = false
}

resource "aws_ssm_parameter" "db_url" {
  name        = var.db_connection_url
  description = "Connection URL for the PostgreSQL database"
  type        = "SecureString"
  value       = "postgresql://${aws_db_instance.db.username}:${random_password.db.result}@${aws_db_instance.db.endpoint}/${var.database_name}"
  #value      =  "Server=${aws_db_instance.db.endpoint};Port=5432;${var.database_name};Username=${aws_db_instance.db.username};Password=${random_password.db.result};sslmode=Require;Trust Server Certificate=true;"
}



data "aws_iam_policy_document" "read_db_url_ssm" {
  version = "2012-10-17"

  statement {
    sid = "AllowReadDbUrlSecret"

    effect = "Allow"

    actions = [
      "ssm:GetParameters"
    ]

    resources = [
      aws_ssm_parameter.db_url.arn
    ]
  }
}