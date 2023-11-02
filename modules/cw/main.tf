resource "aws_cloudwatch_log_group" "web" {
  for_each          = var.web
  name              = "/ecs/${var.env}-${each.value.app_name}"
  retention_in_days = var.retention_in_days
  #kms_key_id        = aws_kms_key.kms_web[each.key].arn
}


resource "aws_cloudwatch_log_group" "security" {
  
  for_each          = var.security
  name              = "/ecs/${var.env}-${each.value.app_name}"
  retention_in_days = var.retention_in_days
  #kms_key_id        = aws_kms_key.kms_security[each.key].arn
}

resource "aws_cloudwatch_log_group" "adaptor" {
  
  for_each          = var.adaptor
  name              = "/ecs/${var.env}-${each.value.app_name}"
  retention_in_days = var.retention_in_days
  #kms_key_id        = aws_kms_key.kms_adaptor[each.key].arn
}

resource "aws_cloudwatch_log_group" "wrapper" {
  
  for_each          = var.wrapper
  name              = "/ecs/${var.env}-${each.value.app_name}"
  retention_in_days = var.retention_in_days
  #kms_key_id        = aws_kms_key.kms_wrapper[each.key].arn
}


resource "aws_cloudwatch_log_group" "validation" {
  
  for_each          = var.validation
  name              = "/ecs/${var.env}-${each.value.app_name}"
  retention_in_days = var.retention_in_days
  #kms_key_id        = aws_kms_key.kms_validation[each.key].arn

}

resource "aws_cloudwatch_log_group" "jobs" {
  
  for_each          = var.jobs
  name              = "/ecs/${var.env}-${each.value.app_name}"
  retention_in_days = var.retention_in_days
  #kms_key_id        = aws_kms_key.kms_jobs[each.key].arn

}

resource "aws_cloudwatch_log_group" "testmvc" {
  
  for_each          = var.testmvc
  name              = "/ecs/${var.env}-${each.value.app_name}"
  retention_in_days = var.retention_in_days
  #kms_key_id        = aws_kms_key.kms_test_mvc[each.key].arn

}

resource "aws_cloudwatch_log_group" "utility" {
  
  for_each          = var.utility
  name              = "/ecs/${var.env}-${each.value.app_name}"
  retention_in_days = var.retention_in_days
  #kms_key_id        = aws_kms_key.kms_utility[each.key].arn

}