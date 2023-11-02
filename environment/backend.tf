terraform {
  backend "s3" {
    bucket         = "bucket_name"
    encrypt        = true
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    profile        = "preprod"
    #dynamodb_table = "terraform-state-lock-dynamo"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  # Enable Point-In-Time Recovery
  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
