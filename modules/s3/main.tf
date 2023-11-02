resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "${var.env}"
  }
}

resource "aws_s3_object" "Templates" {
  bucket = aws_s3_bucket.bucket.id
  key    = "Templates/"
}

resource "aws_s3_object" "Uploads" {
  bucket = aws_s3_bucket.bucket.id
  key    = "Uploads/"
}

resource "aws_s3_object" "datamigrationuploads" {
  bucket = aws_s3_bucket.bucket.id
  key    = "datamigrationuploads/"
}


resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket              = aws_s3_bucket.bucket.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}


resource "aws_s3_bucket_server_side_encryption_configuration" "aes_encryption" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#AWS_Backup_Configuration
#==========================

resource "aws_iam_role" "s3_backup_role" {
  name = "${var.bucket_name}-backup-role"

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


resource "aws_iam_role_policy_attachment" "backup_s3_role_attachment" {
  role       = aws_iam_role.s3_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupFullAccess"
}

resource "aws_iam_role_policy_attachment" "backup_role_attachment_s3" {
  role       = aws_iam_role.s3_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "backup_role_attachment_cw" {
  role       = aws_iam_role.s3_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_kms_key" "backup_s3_key" {
  deletion_window_in_days = 10
}

resource "aws_backup_vault" "backup_vault_s3" {
  name        = "${var.bucket_name}-vault"
  kms_key_arn = aws_kms_key.backup_s3_key.arn
}


resource "aws_backup_plan" "backup_plan_s3" {
  name = "${var.bucket_name}-backup-plan"

  rule {
    rule_name         = "${var.bucket_name}-plan"
    target_vault_name = aws_backup_vault.backup_vault_s3.name
    schedule          = "cron(00 17 * * ? *)"
    lifecycle {
      delete_after = 2555 
    }
  }
}

resource "aws_backup_selection" "backup_s3" {
  name             = "backup_selection_s3"
  plan_id   = aws_backup_plan.backup_plan_s3.id
  iam_role_arn     = aws_iam_role.s3_backup_role.arn

  resources = [
    aws_s3_bucket.bucket.arn
  ]
}