resource "aws_appautoscaling_target" "security_scale_target" {
  for_each = var.security
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.test-cluster.name}/${var.env}-${each.key}"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = var.ecs_autoscale_max_instances
  min_capacity       = var.ecs_autoscale_min_instances
  depends_on = [
    aws_ecs_service.security-service
  ]
}

resource "aws_appautoscaling_target" "adaptor_scale_target" {
  for_each = var.adaptor
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.test-cluster.name}/${var.env}-${each.key}"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = var.ecs_autoscale_max_instances
  min_capacity       = var.ecs_autoscale_min_instances
  depends_on = [
    aws_ecs_service.adaptor-service
  ]
}

resource "aws_appautoscaling_target" "wrapper_scale_target" {
  for_each = var.wrapper
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.test-cluster.name}/${var.env}-${each.key}"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = var.ecs_autoscale_max_instances
  min_capacity       = var.ecs_autoscale_min_instances
  depends_on = [
    aws_ecs_service.wrapper-service
  ]
}

resource "aws_appautoscaling_target" "validation_scale_target" {
  for_each = var.validation
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.test-cluster.name}/${var.env}-${each.key}"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = var.ecs_autoscale_max_instances
  min_capacity       = var.ecs_autoscale_min_instances
  depends_on = [
    aws_ecs_service.validation-service
  ]
}

resource "aws_appautoscaling_target" "web_scale_target" {
  for_each = var.web
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.test-cluster.name}/${var.env}-${each.key}"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = var.ecs_autoscale_max_instances
  min_capacity       = var.ecs_autoscale_min_instances
  depends_on = [
    aws_ecs_service.frontend-service
  ]
}