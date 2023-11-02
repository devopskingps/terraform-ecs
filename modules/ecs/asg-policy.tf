resource "aws_appautoscaling_policy" "security_app_up" {
  for_each           = var.security
  name               = "${var.env}-${each.key}-scale-up"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.security_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.security_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "adaptor_app_up" {
  for_each           = var.adaptor
  name               = "${var.env}-${each.key}-scale-up"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.adaptor_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.adaptor_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}


resource "aws_appautoscaling_policy" "wrapper_app_up" {
  for_each           = var.wrapper
  name               = "${var.env}-${each.key}-scale-up"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.wrapper_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.wrapper_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}


resource "aws_appautoscaling_policy" "validation_app_up" {
  for_each           = var.validation
  name               = "${var.env}-${each.key}-scale-up"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.validation_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.validation_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "web_app_up" {
  for_each           = var.web
  name               = "${var.env}-${each.key}-scale-up"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.web_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.web_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "web_app_down" {
  for_each           = var.web
  name               = "${var.env}-${each.key}-scale-down"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.web_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.web_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}




resource "aws_appautoscaling_policy" "security_app_down" {
  for_each           = var.security
  name               = "${var.env}-${each.key}-scale-down"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.security_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.security_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}


resource "aws_appautoscaling_policy" "adaptor_app_down" {
  for_each           = var.adaptor
  name               = "${var.env}-${each.key}-scale-down"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.adaptor_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.adaptor_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}


resource "aws_appautoscaling_policy" "wrapper_app_down" {
  for_each           = var.wrapper
  name               = "${var.env}-${each.key}-scale-down"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.wrapper_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.wrapper_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}


resource "aws_appautoscaling_policy" "validation_app_down" {
  for_each           = var.validation
  name               = "${var.env}-${each.key}-scale-down"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.validation_scale_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.validation_scale_target[each.key].scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}
