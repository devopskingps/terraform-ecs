# resource "aws_kms_key" "kms_web" {
#   for_each = var.web

#   description             = "${each.key}_kms_key"
#   deletion_window_in_days = 30
#   tags = {
#     Name = "${each.key}"
#   }
# }


# resource "aws_kms_key" "kms_security" {
#   for_each = var.security

#   description             = "${each.key}_kms_key"
#   deletion_window_in_days = 30
#   tags = {
#     Name = "${each.key}"
#   }
# }

# resource "aws_kms_key" "kms_adaptor" {
#   for_each = var.adaptor

#   description             = "${each.key}_kms_key"
#   deletion_window_in_days = 30
#   tags = {
#     Name = "${each.key}"
#   }
# }

# resource "aws_kms_key" "kms_wrapper" {
#   for_each = var.wrapper

#   description             = "${each.key}_kms_key"
#   deletion_window_in_days = 30
#   tags = {
#     Name = "${each.key}"
#   }
# }


# resource "aws_kms_key" "kms_validation" {
#   for_each = var.validation

#   description             = "${each.key}_kms_key"
#   deletion_window_in_days = 30
#   tags = {
#     Name = "${each.key}"
#   }
# }


# resource "aws_kms_key" "kms_jobs" {
#   for_each = var.jobs

#   description             = "${each.key}_kms_key"
#   deletion_window_in_days = 30
#   tags = {
#     Name = "${each.key}"
#   }
# }

# resource "aws_kms_key" "kms_test_mvc" {
#   for_each = var.testmvc

#   description             = "${each.key}_kms_key"
#   deletion_window_in_days = 30
#   tags = {
#     Name = "${each.key}"
#   }
# }

# resource "aws_kms_key" "kms_utility" {
#   for_each = var.utility

#   description             = "${each.key}_kms_key"
#   deletion_window_in_days = 30
#   tags = {
#     Name = "${each.key}"
#   }
# }

