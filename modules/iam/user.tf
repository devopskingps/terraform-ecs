#Create_User for application Access
#====================================

resource "aws_iam_user" "ppg_app_user" {
  name = "ppg-${var.env}-app-user"
}

resource "aws_iam_access_key" "ppg_app_user_access_key" {
  user = aws_iam_user.ppg_app_user.name
}

resource "aws_ssm_parameter" "ppg_app_user_access_key_id" {
  name  = "ACCESSKEYID"
  value = aws_iam_access_key.ppg_app_user_access_key.id
  type  = "SecureString" 
  overwrite = true
}

resource "aws_ssm_parameter" "ppg_app_user_secret_access_key" {
  name  = "ACCESSKEYSECRET"
  value = aws_iam_access_key.ppg_app_user_access_key.secret
  type  = "SecureString"
  overwrite = true
}

resource "aws_ssm_parameter" "region_key" {
  name  = "REGION"
  value = var.region
  type  = "SecureString"
  overwrite = true
}

resource "aws_ssm_parameter" "startup_url_key" {
  name  = "STARTUP_URL"
  value = var.startup_url
  type  = "SecureString"
  overwrite = true
}

# S3 IAM Policy
data "aws_iam_policy_document" "s3_policy" {
  statement {
    effect = "Allow"
    actions = ["s3:PutObject", "s3:GetObject", "s3:GetBucketLocation", "s3:ListBucket", "s3:GetBucketVersioning"]
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]  # Replace 'your-bucket-name' with your actual bucket name
  }
}

resource "aws_iam_policy" "s3_policy" {
  name        = "S3_Access_Policy"
  description = "IAM policy for S3 access"
  policy      = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_iam_user_policy_attachment" "s3_attachment" {
  user       = aws_iam_user.ppg_app_user.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# SQS IAM Policy
data "aws_iam_policy_document" "sqs_policy" {
  statement {
    effect = "Allow"
    actions = ["sqs:GetQueueAttributes", "sqs:SendMessage", "sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:SendMessageBatch", "sqs:GetQueueUrl" ]
    resources = [
      "arn:aws:sqs:eu-west-2:${var.account}:data.fifo",
      "arn:aws:sqs:eu-west-2:${var.account}:notification.fifo",
      "arn:aws:sqs:eu-west-2:${var.account}:push.fifo"
    ]
  }
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "SQS_Access_Policy"
  description = "IAM policy for SQS access"
  policy      = data.aws_iam_policy_document.sqs_policy.json
}

resource "aws_iam_user_policy_attachment" "sqs_attachment" {
  user       = aws_iam_user.ppg_app_user.name
  policy_arn = aws_iam_policy.sqs_policy.arn
}


data "aws_iam_policy_document" "ssm_policy" {
  version = "2012-10-17"

  statement {
    effect  = "Allow"
    actions = ["ssm:GetParametersByPath","ssm:GetParameter","ssm:PutParameter","ssm:DeleteParameter","ssm:DeleteParameters"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ssm_get_policy" {
  name        = "SSM_Policy"
  description = "IAM policy to get parameters from SSM"
  policy      = data.aws_iam_policy_document.ssm_policy.json
}

resource "aws_iam_user_policy_attachment" "ssm_policy_attachment" {
  policy_arn = aws_iam_policy.ssm_get_policy.arn
  user       = aws_iam_user.ppg_app_user.name
}
