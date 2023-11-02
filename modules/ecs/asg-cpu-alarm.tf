resource "aws_cloudwatch_metric_alarm" "security_cpu_utilization_high" {
  for_each            = var.security
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-High-${var.ecs_as_cpu_high_threshold_per}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_high_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.security-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.security_app_up[each.key].arn]
}

resource "aws_cloudwatch_metric_alarm" "adaptor_cpu_utilization_high" {
  for_each            = var.adaptor
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-High-${var.ecs_as_cpu_high_threshold_per}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_high_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.adaptor-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.adaptor_app_up[each.key].arn]
}

resource "aws_cloudwatch_metric_alarm" "wrapper_cpu_utilization_high" {
  for_each            = var.wrapper
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-High-${var.ecs_as_cpu_high_threshold_per}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_high_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.wrapper-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.wrapper_app_up[each.key].arn]
}

resource "aws_cloudwatch_metric_alarm" "validation_cpu_utilization_high" {
  for_each            = var.validation
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-High-${var.ecs_as_cpu_high_threshold_per}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_high_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.validation-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.validation_app_up[each.key].arn]
}


resource "aws_cloudwatch_metric_alarm" "web_cpu_utilization_high" {
  for_each            = var.web
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-High-${var.ecs_as_cpu_high_threshold_per}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_high_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.frontend-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.web_app_up[each.key].arn]
}


resource "aws_cloudwatch_metric_alarm" "web_cpu_utilization_low" {
  for_each            = var.web
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-Low-${var.ecs_as_cpu_low_threshold_per}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_low_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.frontend-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.web_app_down[each.key].arn]
}


resource "aws_cloudwatch_metric_alarm" "security_cpu_utilization_low" {
  for_each            = var.security
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-Low-${var.ecs_as_cpu_low_threshold_per}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_low_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.security-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.security_app_down[each.key].arn]
}


resource "aws_cloudwatch_metric_alarm" "adaptor_cpu_utilization_low" {
  for_each            = var.adaptor
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-Low-${var.ecs_as_cpu_low_threshold_per}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_low_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.adaptor-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.adaptor_app_down[each.key].arn]
}


resource "aws_cloudwatch_metric_alarm" "wrapper_cpu_utilization_low" {
  for_each            = var.wrapper
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-Low-${var.ecs_as_cpu_low_threshold_per}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_low_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.wrapper-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.wrapper_app_down[each.key].arn]
}


resource "aws_cloudwatch_metric_alarm" "validation_cpu_utilization_low" {
  for_each            = var.validation
  alarm_name          = "${var.env}-${each.key}-CPU-Utilization-Low-${var.ecs_as_cpu_low_threshold_per}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.ecs_as_cpu_low_threshold_per

  dimensions = {
    ClusterName = aws_ecs_cluster.test-cluster.name
    ServiceName = aws_ecs_service.validation-service[each.key].name
  }

  alarm_actions = [aws_appautoscaling_policy.validation_app_down[each.key].arn]
}