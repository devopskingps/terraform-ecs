resource "aws_s3_bucket" "alb_logs_bucket" {
  bucket = "${var.env}accessslogalbbucket"
}

resource "aws_s3_bucket_versioning" "alb_logs_bucket_versioning" {
  bucket = aws_s3_bucket.alb_logs_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.alb_logs_bucket.id
  policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.default.arn]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.alb_logs_bucket.arn}/*",
    ]
  }
}


data "aws_elb_service_account" "default" {}