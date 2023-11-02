output "target_group_arn_security" {
  value = aws_alb_target_group.security_apps_tg["security"].arn
}

output "target_group_arn_adaptor" {
  value = aws_alb_target_group.adaptor_apps_tg["adaptor"].arn
}


output "target_group_arn_dashboardwrapper" {
  value = aws_alb_target_group.wrapper_apps_tg["dashboard-wrapper"].arn
}

output "target_group_arn_wrapper" {
  value = aws_alb_target_group.wrapper_apps_tg["wrapper"].arn
}


output "target_group_arn_users" {
  value = aws_alb_target_group.wrapper_apps_tg["users"].arn
}

output "target_group_arn_configurations" {
  value = aws_alb_target_group.wrapper_apps_tg["configurations"].arn
}

output "target_group_arn_organisations" {
  value = aws_alb_target_group.wrapper_apps_tg["organisations"].arn
}

output "target_group_arn_contacts" {
 value = aws_alb_target_group.wrapper_apps_tg["contacts"].arn
}



output "target_group_arn_buyervalidation" {
  value = aws_alb_target_group.validation_apps_tg["buyervalidation"].arn
}

output "target_group_arn_notification" {
  value = aws_alb_target_group.validation_apps_tg["notification"].arn
}


output "target_group_arn_demo_mvc" {
  value = aws_alb_target_group.testmvc_apps_tg["demo-mvc"].arn
}

output "target_group_arn_demo_mvc_saml" {
  value = aws_alb_target_group.testmvc_apps_tg["demo-mvc-saml"].arn
}

output "target_group_arn_ssm_api" {
  value = aws_alb_target_group.utility_apps_tg["ssm-api"].arn
}