resource "aws_ecs_cluster" "test-cluster" {
  name = "${upper(var.org)}-${upper(var.environment)}"
  tags = {
    Name        = "${var.org}"
    Environment = "${var.environment}"
  }
}

data "template_file" "security" {
  for_each = var.security
  template = file("../modules/ecs/templates/image/app.json")

  vars = {
    app_name       = "${var.env}-${each.value.app_name}"
    app_image      = each.value.app_image
    app_port       = each.value.app_port
    fargate_cpu    = each.value.fargate_cpu
    fargate_memory = each.value.fargate_memory
    aws_region     = var.aws_region
    account        = var.account
    env            = var.env
  }
}

data "template_file" "adaptor" {
  for_each = var.adaptor
  template = file("../modules/ecs/templates/image/app.json")

  vars = {
    app_name       = "${var.env}-${each.value.app_name}"
    app_image      = each.value.app_image
    app_port       = each.value.app_port
    fargate_cpu    = each.value.fargate_cpu
    fargate_memory = each.value.fargate_memory
    aws_region     = var.aws_region
    account        = var.account
    env            = var.env
  }
}


data "template_file" "wrapper" {
  for_each = var.wrapper
  template = file("../modules/ecs/templates/image/app.json")

  vars = {
    app_name       = "${var.env}-${each.value.app_name}"
    app_image      = each.value.app_image
    app_port       = each.value.app_port
    fargate_cpu    = each.value.fargate_cpu
    fargate_memory = each.value.fargate_memory
    aws_region     = var.aws_region
    account        = var.account
    env            = var.env
  }
}


data "template_file" "validation" {
  for_each = var.validation
  template = file("../modules/ecs/templates/image/app.json")

  vars = {
    app_name       = "${var.env}-${each.value.app_name}"
    app_image      = each.value.app_image
    app_port       = each.value.app_port
    fargate_cpu    = each.value.fargate_cpu
    fargate_memory = each.value.fargate_memory
    aws_region     = var.aws_region
    account        = var.account
    env            = var.env
  }
}

data "template_file" "testmvc" {
  for_each = var.testmvc
  template = file("../modules/ecs/templates/image/app.json")

  vars = {
    app_name       = "${var.env}-${each.value.app_name}"
    app_image      = each.value.app_image
    app_port       = each.value.app_port
    fargate_cpu    = each.value.fargate_cpu
    fargate_memory = each.value.fargate_memory
    aws_region     = var.aws_region
    account        = var.account
    env            = var.env
  }
}

data "template_file" "utility" {
  for_each = var.utility
  template = file("../modules/ecs/templates/image/app.json")

  vars = {
    app_name       = "${var.env}-${each.value.app_name}"
    app_image      = each.value.app_image
    app_port       = each.value.app_port
    fargate_cpu    = each.value.fargate_cpu
    fargate_memory = each.value.fargate_memory
    aws_region     = var.aws_region
    account        = var.account
    env            = var.env
  }
}

data "template_file" "web" {
  for_each = var.web
  template = file("../modules/ecs/templates/image/web.json")

  vars = {
    app_name       = "${var.env}-${each.value.app_name}"
    app_image      = each.value.app_image
    app_port       = each.value.app_port
    fargate_cpu    = each.value.fargate_cpu
    fargate_memory = each.value.fargate_memory
    aws_region     = var.aws_region
    account        = var.account
    env            = var.env
  }
}

data "template_file" "job" {
  for_each = var.jobs
  template = file("../modules/ecs/templates/image/job.json")

  vars = {
    app_name       = "${var.env}-${each.value.app_name}"
    app_image      = each.value.app_image
    app_port       = each.value.app_port
    fargate_cpu    = each.value.fargate_cpu
    fargate_memory = each.value.fargate_memory
    aws_region     = var.aws_region
    account        = var.account
    env            = var.env
  }
}


resource "aws_ecs_task_definition" "security" {
  for_each                = var.security
  family                  = "${var.env}-${each.key}"
  execution_role_arn      = var.ecs_task_execution_role
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = each.value.fargate_cpu
  memory                  = each.value.fargate_memory
  container_definitions = data.template_file.security[each.key].rendered
}

resource "aws_ecs_task_definition" "adaptor" {
  for_each                = var.adaptor
  family                  = "${var.env}-${each.key}"
  execution_role_arn      = var.ecs_task_execution_role
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = each.value.fargate_cpu
  memory                  = each.value.fargate_memory
  container_definitions = data.template_file.adaptor[each.key].rendered
}

resource "aws_ecs_task_definition" "wrapper" {
  for_each                = var.wrapper
  family                  = "${var.env}-${each.key}"
  execution_role_arn      = var.ecs_task_execution_role
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = each.value.fargate_cpu
  memory                  = each.value.fargate_memory
  container_definitions = data.template_file.wrapper[each.key].rendered
}

resource "aws_ecs_task_definition" "validation" {
  for_each                = var.validation
  family                  = "${var.env}-${each.key}"
  execution_role_arn      = var.ecs_task_execution_role
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = each.value.fargate_cpu
  memory                  = each.value.fargate_memory
  container_definitions = data.template_file.validation[each.key].rendered
}

resource "aws_ecs_task_definition" "testmvc" {
  for_each                = var.testmvc
  family                  = "${var.env}-${each.key}"
  execution_role_arn      = var.ecs_task_execution_role
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = each.value.fargate_cpu
  memory                  = each.value.fargate_memory
  container_definitions = data.template_file.testmvc[each.key].rendered
}

resource "aws_ecs_task_definition" "utility" {
  for_each                = var.utility
  family                  = "${var.env}-${each.key}"
  execution_role_arn      = var.ecs_task_execution_role
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = each.value.fargate_cpu
  memory                  = each.value.fargate_memory
  container_definitions = data.template_file.utility[each.key].rendered
}


resource "aws_ecs_task_definition" "web" {
  for_each                = var.web
  family                  = "${var.env}-${each.key}"
  execution_role_arn      = var.ecs_task_execution_role
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = var.fargate_cpu
  memory                  = var.fargate_memory
  container_definitions = data.template_file.web[each.key].rendered
}


resource "aws_ecs_task_definition" "job" {
  for_each                = var.jobs
  family                  = "${var.env}-${each.key}"
  execution_role_arn      = var.ecs_task_execution_role
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = var.fargate_cpu
  memory                  = var.fargate_memory
  container_definitions = data.template_file.job[each.key].rendered
}


resource "aws_alb_target_group" "security_apps_tg" {
  for_each                = var.security
  name        = "${var.env}-${each.key}"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  stickiness {
    enabled = true
    type    = "lb_cookie"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path_bk
    interval            = 30
  }

  lifecycle {
    ignore_changes = [
      health_check.0.path  # Ignore changes to the path attribute within health_check
    ]
  }

}


resource "aws_ecs_service" "security-service" {
  for_each                = var.security
  name            = "${var.env}-${each.key}"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.security[each.key].arn
  desired_count   = var.app_count_security
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }

  network_configuration {
    security_groups = [aws_security_group.security_sg[each.key].id]
    subnets = var.subnets
    assign_public_ip = true
  }

  load_balancer {
  target_group_arn = aws_alb_target_group.security_apps_tg[each.key].arn
  container_name   = "${var.env}-${each.key}"
  container_port   = var.app_port
}

  depends_on = [ var.alb_backend ]
}

resource "aws_alb_target_group" "adaptor_apps_tg" {
  for_each                = var.adaptor
  name        = "${var.env}-${each.key}"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path_bk
    interval            = 30
  }

  lifecycle {
    ignore_changes = [
      health_check.0.path  # Ignore changes to the path attribute within health_check
    ]
  }

}


resource "aws_ecs_service" "adaptor-service" {
  for_each                = var.adaptor
  name            = "${var.env}-${each.key}"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.adaptor[each.key].arn
  desired_count   = var.app_count_adaptor
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }
  network_configuration {
    security_groups = [aws_security_group.adaptor_sg[each.key].id]
    subnets = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.adaptor_apps_tg[each.key].arn
    container_name   = "${var.env}-${each.key}"
    container_port   = var.app_port
  }

  depends_on = [ var.alb_backend ]
}


resource "aws_alb_target_group" "wrapper_apps_tg" {
  for_each                = var.wrapper
  name        = "${var.env}-${each.key}"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path_bk
    interval            = 30
  }
  lifecycle {
    ignore_changes = [
      health_check.0.path  # Ignore changes to the path attribute within health_check
    ]
  }
}



resource "aws_ecs_service" "wrapper-service" {
  for_each                = var.wrapper
  name            = "${var.env}-${each.key}"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.wrapper[each.key].arn
  desired_count   = var.app_count_wrapper
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }

  network_configuration {
    security_groups = [aws_security_group.wrapper_sg[each.key].id]
    subnets = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.wrapper_apps_tg[each.key].arn
    container_name   = "${var.env}-${each.key}"
    container_port   = var.app_port
  }

  depends_on = [ var.alb_backend ]
}

resource "aws_alb_target_group" "validation_apps_tg" {
  for_each                = var.validation
  name        = "${var.env}-${each.key}"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path_bk
    interval            = 30
  }
  lifecycle {
    ignore_changes = [
      health_check.0.path  # Ignore changes to the path attribute within health_check
    ]
  }
}


resource "aws_ecs_service" "validation-service" {
  for_each                = var.validation
  name            = "${var.env}-${each.key}"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.validation[each.key].arn
  desired_count   = var.app_count_validation
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }

  network_configuration {
    security_groups = [aws_security_group.validation_sg[each.key].id]
    subnets = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.validation_apps_tg[each.key].arn
    container_name   = "${var.env}-${each.key}"
    container_port   = var.app_port
  }

  depends_on = [ var.alb_backend ]
}

resource "aws_alb_target_group" "testmvc_apps_tg" {
  for_each                = var.testmvc
  name        = "${var.env}-${each.key}"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = "/"
    interval            = 30
  }

  lifecycle {
    ignore_changes = [
      health_check.0.path  # Ignore changes to the path attribute within health_check
    ]
  }
}


resource "aws_ecs_service" "testmvc-service" {
  for_each                = var.testmvc
  name            = "${var.env}-${each.key}"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.testmvc[each.key].arn
  desired_count   = var.app_count_testmvc
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }

  network_configuration {
    security_groups = [aws_security_group.testmvc_sg[each.key].id]
    subnets = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.testmvc_apps_tg[each.key].arn
    container_name   = "${var.env}-${each.key}"
    container_port   = var.app_port
  }

  depends_on = [ var.alb_backend ]
}

resource "aws_alb_target_group" "utility_apps_tg" {
  for_each                = var.utility
  name        = "${var.env}-${each.key}"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = "/swagger/index.html"
    interval            = 30
  }
  lifecycle {
    ignore_changes = [
      health_check.0.path  # Ignore changes to the path attribute within health_check
    ]
  }
}


resource "aws_ecs_service" "utility_apps_tg-service" {
  for_each                = var.utility
  name            = "${var.env}-${each.key}"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.utility[each.key].arn
  desired_count   = var.app_count_utility
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }

  network_configuration {
    security_groups = [aws_security_group.utility_sg[each.key].id]
    subnets = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.utility_apps_tg[each.key].arn
    container_name   = "${var.env}-${each.key}"
    container_port   = var.app_port
  }

  depends_on = [ var.alb_backend ]
}



resource "aws_ecs_service" "frontend-service" {
  for_each                = var.web
  name            = "${var.env}-${each.key}"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.web[each.key].arn
  desired_count   = var.app_count_frontend
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }

  network_configuration {
    security_groups = [aws_security_group.web_sg[each.key].id]
    subnets        = var.subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn_frontend
    container_name   = "${var.env}-${each.key}"
    container_port   = var.web_port
  }

  depends_on = [ var.alb_frontend ]
}




resource "aws_ecs_service" "background-jobs" {
  for_each                = var.jobs
  name            = "${var.env}-${each.key}"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.job[each.key].arn
  desired_count   = var.app_count_jobs
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }

  network_configuration {
    security_groups = [aws_security_group.job_sg[each.key].id]
    subnets        = var.subnet_ids
    assign_public_ip = true
  }

}