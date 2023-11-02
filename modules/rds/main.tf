resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.env}-${var.database_name}-rds-subnet-group"
  description = "DB subnet group for PostgreSQL RDS instance"

  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.env}-${var.database_name}-rds-subnet-group"
  }
}


resource "aws_db_instance" "db" {
  identifier           = var.db_indentifier
  engine               = var.engine
  instance_class       = var.instance_type
  allocated_storage    = var.allocated_storage
  db_name              = var.database_name
  username             = var.database_user
  password             = random_password.db.result
  port                 = var.database_port
  engine_version       = var.engine_version
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted    = var.storage_encrypted
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  availability_zone    = var.availability_zone[0]
  #charset_name       = var.charset_name
  skip_final_snapshot = var.skip_final_snapshot
  final_snapshot_identifier = "my-final-snapshot"
  # Enable IAM Database Authentication
  iam_database_authentication_enabled = true
  # Enable automated backups and set retention period
  backup_retention_period = 7  # Retain backups for 7 days

  # Enable CloudWatch logging
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  multi_az             = true
  apply_immediately    = true
  
  lifecycle {
    ignore_changes = [
      backup_retention_period,
      iam_database_authentication_enabled,
    ]
  }
  
}


resource "aws_security_group" "rds_sg" {
  name = "${var.database_name}-db-sg"
  description = "RDS ${var.database_name}"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.database_name}"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "backup_role" {
  name = "${var.database_name}-rds-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "backup.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "backup_role_attachment" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupFullAccess"
}

resource "aws_iam_role_policy_attachment" "backup_role_attachment_rds" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_kms_key" "backup_key" {
  deletion_window_in_days = 10
}

resource "aws_backup_vault" "backup_vault" {
  name        = "${var.database_name}-vault"
  kms_key_arn = aws_kms_key.backup_key.arn
}


resource "aws_backup_plan" "backup_plan" {
  name = "${var.database_name}-backup-plan"

  rule {
    rule_name         = "${var.database_name}-plan"
    target_vault_name = aws_backup_vault.backup_vault.name
    schedule          = "cron(24 15 * * ? *)"

    lifecycle {
      delete_after = 2555 
    }
  }
}

resource "aws_backup_selection" "backup" {
  name             = "backup_selection_rds"
  plan_id   = aws_backup_plan.backup_plan.id
  iam_role_arn     = aws_iam_role.backup_role.arn

  resources = [
    aws_db_instance.db.arn
  ]
}