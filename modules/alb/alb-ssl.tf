#Note:
#======
#Keeping both path based routing and multiple listeners to make sure the enviornments up  and running,
#ports will be ignored for higher environments.
#Path based routing only applicable for higher environments

#Load balancer for frontend
#===========================

resource "aws_alb" "alb-frontend" {
  name           = "${var.env}-alb-frontend"
  load_balancer_type = "application"
  subnets        = var.subnet_ids
  security_groups = [aws_security_group.alb-frontend-sg.id]
  enable_deletion_protection = true
  access_logs {
    bucket = aws_s3_bucket.alb_logs_bucket.id
    prefix = "alb-logs/frontend"
    enabled = true
  }

  tags = {
    Name = "${var.env}-alb-frontend"
  }
}

#Load balancer for Backend
#=========================

resource "aws_alb" "alb-backend_alb" {
  name           = "${var.env}-alb-backend"
  load_balancer_type = "application"
  subnets        = var.subnet_ids
  security_groups = [aws_security_group.alb-backend-sg.id]
  enable_deletion_protection = true
  access_logs {
    bucket = aws_s3_bucket.alb_logs_bucket.id
    prefix = "alb-logs/backend"
    enabled = true
  }
  tags = {
    Name = "${var.env}-alb-backend"
  }
}

resource "null_resource" "wait_for_alb_frontend" {
  provisioner "local-exec" {
    command = "echo 'ALB created'"
  }

  depends_on = [aws_alb.alb-frontend]
}

resource "null_resource" "wait_for_alb_backend" {
  provisioner "local-exec" {
    command = "echo 'ALB created'"
  }

  depends_on = [aws_alb.alb-backend_alb]
}

#Frontend Target group with port 80 for angular application
#==========================================================

resource "aws_alb_target_group" "frontend-tg" {
  name        = "frontend-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path
    interval            = 30
  }

  tags = {
    Name        = "frontend-tg"
    Environment = "${var.env}"
  }
}


resource "aws_alb_listener" "frontend" {
  load_balancer_arn = aws_alb.alb-frontend.id
  port              =  var.use_https ? 443 : 80
  protocol          = var.use_https ? "HTTPS" : "HTTP"
  ssl_policy        = var.use_https ? "ELBSecurityPolicy-TLS13-1-2-Res-2021-06" : null
  certificate_arn   = var.use_https ? var.certificate_arn : null


  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.frontend-tg.arn
  }

  tags = {
    Name        = "frontend-listener"
    Environment = var.env
  }
}

#Postgres Target group for backend applications
#===============================================

resource "aws_alb_target_group" "postgres-tg" {
  name        = "${var.env}-postgres-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    #path                = var.health_check_path
    path                = "/health"
    interval            = 30
  }

  tags = {
    Name        = "backend-tg"
    Environment = "${var.env}"
  }
}

#Frontend Target group for backend applications
#===============================================

resource "aws_alb_target_group" "backend-tg" {
  name        = "backend-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path
    interval            = 30
  }

  tags = {
    Name        = "backend-tg"
    Environment = "${var.env}"
  }
}


#Listener with port 443
#======================

# resource "aws_alb_listener" "backend" {
#   load_balancer_arn = aws_alb.alb-backend_alb.id
#   port              = 443
#   protocol          = "HTTPS"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.backend-tg.arn
#   }
#   ssl_policy = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
#   certificate_arn = var.certificate_arn_backend
#   tags = {
#     Name        = "backend-listener"
#     Environment = "${var.env}"
#   }
# }

resource "aws_alb_listener" "backend" {
  load_balancer_arn = aws_alb.alb-backend_alb.id
  port              =  var.use_https ? 443 : 80
  protocol          = var.use_https ? "HTTPS" : "HTTP"
  ssl_policy        = var.use_https ? "ELBSecurityPolicy-TLS13-1-2-Res-2021-06" : null
  certificate_arn   = var.use_https ? var.certificate_arn_backend : null


  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.backend-tg.arn
  }

  tags = {
    Name        = "backend-listener"
    Environment = var.env
  }
}



#Listener rule for dashboard-wrapper
#===================================

resource "aws_lb_listener_rule" "dashboard_wrapper_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_dashboardwrapper
  }

  condition {
    path_pattern {
      values = ["/dashboard-wrapper/*"]
    }
  }
}

resource "aws_lb_listener_rule" "dashboard_wrapper_root_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 114

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_dashboardwrapper
  }

  condition {
    path_pattern {
      values = ["/dashboard-wrapper"]
    }
  }
}


#Listener rule for security-API
#==============================

resource "aws_lb_listener_rule" "security_well_known_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 110

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_security
  }

  condition {
    path_pattern {
      values = ["/.well-known/*"]
    }
  }
}

resource "aws_lb_listener_rule" "security_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_security
  }

  condition {
    path_pattern {
      values = ["/security/*"]
    }
  }
}

resource "aws_lb_listener_rule" "security_root_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 113

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_security
  }

  condition {
    path_pattern {
      values = ["/security"]
    }
  }
}


resource "aws_lb_listener_rule" "security_root_path_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 116

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_security
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}


#Listener rule for adaptor-service
#===================================

resource "aws_lb_listener_rule" "adaptor-service_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 102

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_adaptor
  }

  condition {
    path_pattern {
      values = ["/adaptor-service/*"]
    }
  }
}

#Listener rule for user-profile
#==============================

resource "aws_lb_listener_rule" "user-profile_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 103

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_users
  }

  condition {
    path_pattern {
      values = ["/user-profile/*"]
    }
  }
}

resource "aws_lb_listener_rule" "user-profile_root_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 111

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_users
  }

  condition {
    path_pattern {
      values = ["/user-profile"]
    }
  }
}

#Listener rule for configuration-service
#=======================================

resource "aws_lb_listener_rule" "configuration-service_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 104

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_configurations
  }

  condition {
    path_pattern {
      values = ["/configuration-service/*"]
    }
  }
}


#Listener rule for organisation-profile
#=======================================

resource "aws_lb_listener_rule" "organisation-profile_root_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 115

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_organisations
  }

  condition {
    path_pattern {
      values = ["/organisation-profile"]
    }
  }
}

resource "aws_lb_listener_rule" "organisation-profile_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 105

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_organisations
  }

  condition {
    path_pattern {
      values = ["/organisation-profile/*"]
    }
  }
}


#Listener rule for contact-service
#=================================

resource "aws_lb_listener_rule" "contact-service_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 106

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_contacts
  }

  condition {
    path_pattern {
      values = ["/contact-service/*"]
    }
  }
}

resource "aws_lb_listener_rule" "contact-service_root_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 117

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_contacts
  }

  condition {
    path_pattern {
      values = ["/contact-service"]
    }
  }
}


#Listener rule for buyer-validation
#==========================================

resource "aws_lb_listener_rule" "buyer-validation_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 107

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_buyervalidation
  }

  condition {
    path_pattern {
      values = ["/buyer-validation/*"]
    }
  }
}

resource "aws_lb_listener_rule" "buyer-validation_root_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 112

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_buyervalidation
  }

  condition {
    path_pattern {
      values = ["/buyer-validation"]
    }
  }
}

#Listener rule for Postgres_service
#==================================

resource "aws_lb_listener_rule" "pgadmin4_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 118

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_bastion
  }

  condition {
    path_pattern {
      values = ["/pgadmin4/*"]
    }
  }
}

resource "aws_lb_listener_rule" "pgadmin4_rule_root_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 119

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_bastion
  }

  condition {
    path_pattern {
      values = ["/pgadmin4"]
    }
  }
}


#Listener rule for notification-service
#======================================

resource "aws_lb_listener_rule" "notification-service_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 108

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_notification
  }

  condition {
    path_pattern {
      values = ["/notification-service/*"]
    }
  }
}

#listener rule for SSM
#=====================

resource "aws_lb_listener_rule" "ssm-service_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 120

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_ssm_api
  }

  condition {
    path_pattern {
      values = ["/awsssm/*"]
    }
  }
}

# #listener rule for buyer-validation-service (will be removed later)
# #==================================================================

# resource "aws_lb_listener_rule" "buyer-validation-service_rule" {
#   listener_arn = "${aws_alb_listener.backend.arn}"
#   priority     = 121

#   action {
#     type             = "forward"
#     target_group_arn = var.target_group_arn_buyervalidation
#   }

#   condition {
#     path_pattern {
#       values = ["/buyer-validation-service/*"]
#     }
#   }
# }

#listener rule for Old Wrapper (will be removed later)
#==================================================================

resource "aws_lb_listener_rule" "wrapper_configurations_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 122

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_wrapper
  }

  condition {
    path_pattern {
      values = ["/configurations/*"]
    }
  }
}

resource "aws_lb_listener_rule" "wrapper_organisations_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 123

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_wrapper
  }

  condition {
    path_pattern {
      values = ["/organisations/*"]
    }
  }
}

resource "aws_lb_listener_rule" "wrapper_organisation_root_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 125

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_wrapper
  }

  condition {
    path_pattern {
      values = ["/organisations"]
    }
  }
}



resource "aws_lb_listener_rule" "wrapper_users_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 124

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_wrapper
  }

  condition {
    path_pattern {
      values = ["/users/*"]
    }
  }
}


resource "aws_lb_listener_rule" "wrapper_contacts_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 128

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_wrapper
  }

  condition {
    path_pattern {
      values = ["/contacts/*"]
    }
  }
}

resource "aws_lb_listener_rule" "wrapper_contact_root_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 126

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_wrapper
  }

  condition {
    path_pattern {
      values = ["/contacts"]
    }
  }
}


resource "aws_lb_listener_rule" "wrapper_datamigration_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 127

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_wrapper
  }

  condition {
    path_pattern {
      values = ["/datamigration/*"]
    }
  }
}

#test-mvc rule
#===============


resource "aws_lb_listener_rule" "testmvc_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 129

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_demo_mvc
  }

  condition {
    path_pattern {
      values = ["/oidc/*"]
    }
  }
}

#test-mvc-saml rule
#===================

resource "aws_lb_listener_rule" "testmvc_saml_rule" {
  listener_arn = "${aws_alb_listener.backend.arn}"
  priority     = 130

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn_demo_mvc_saml
  }

  condition {
    path_pattern {
      values = ["/saml/*"]
    }
  }
}