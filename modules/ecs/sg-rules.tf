#Security Group rules to enable Frontend service port to Frontend Load balancer
#============================================================================
resource "aws_security_group_rule" "web_sg_rule" {
  for_each                  = var.web
  source_security_group_id  = var.security_groups_frontend
  security_group_id         = aws_security_group.web_sg[each.key].id
  description               =   "Allow 80 inwards to alb from clients"
  from_port                 = 80
  protocol                  = "tcp"
  to_port                   = 80
  type                      = "ingress"
}

#Security_API security group configuration:
#==========================================

resource "aws_security_group_rule" "security_sg_rule_alb" {
  for_each = var.security
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.security_sg[each.key].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "security_sg_rule_private" {
  for_each                  = var.security
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.security_sg[each.key].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "security_sg_rule_rds" {
  for_each                  = var.security
  source_security_group_id  = var.security_groups_rds_security
  security_group_id         = aws_security_group.security_sg[each.key].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "security_sg_rule_redis" {
  for_each                  = var.security
  security_group_id         = aws_security_group.security_sg[each.key].id
  source_security_group_id  =   var.security_groups_redis_security
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}


#Adaptor_API security group configuration:
#==========================================


resource "aws_security_group_rule" "adaptor_sg_rule_alb" {
  for_each = var.adaptor
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.adaptor_sg[each.key].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "adaptor_sg_rule_private" {
  for_each                  = var.adaptor
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.adaptor_sg[each.key].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "adaptor_sg_rule_rds" {
  for_each                  = var.adaptor
  source_security_group_id  = var.security_groups_rds_adaptor
  security_group_id         = aws_security_group.adaptor_sg[each.key].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "adaptor_sg_rule_redis" {
  for_each                  = var.adaptor
  security_group_id         = aws_security_group.adaptor_sg[each.key].id
  source_security_group_id  = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}


#Dashboard_wrapper_API security group configuration:
#==========================================


resource "aws_security_group_rule" "dashboard_wrapper_sg_rule_alb" {
  #for_each = var.adaptor
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.wrapper_sg["dashboard-wrapper"].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "dashboard_wrapper_sg_rule_private" {
  #for_each                  = var.adaptor
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.wrapper_sg["dashboard-wrapper"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "dashboard_wrapper_sg_rule_rds" {
  #for_each                  = var.adaptor
  source_security_group_id  = var.security_groups_rds_wrapper
  security_group_id         = aws_security_group.wrapper_sg["dashboard-wrapper"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "dashboard_wrapper_sg_rule_redis" {
  #for_each                  = var.adaptor
  security_group_id         = aws_security_group.wrapper_sg["dashboard-wrapper"].id
  source_security_group_id  = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}


#Wrapper_API security group configuration:
#==========================================


resource "aws_security_group_rule" "wrapper_sg_rule_alb" {
  #for_each = var.adaptor
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.wrapper_sg["wrapper"].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "wrapper_sg_rule_private" {
  #for_each                  = var.adaptor
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.wrapper_sg["wrapper"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "wrapper_sg_rule_rds" {
  #for_each                  = var.adaptor
  source_security_group_id  = var.security_groups_rds_wrapper
  security_group_id         = aws_security_group.wrapper_sg["wrapper"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "wrapper_sg_rule_redis" {
  #for_each                  = var.adaptor
  security_group_id         = aws_security_group.wrapper_sg["wrapper"].id
  source_security_group_id  = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}


#Contact_API security group configuration:
#==========================================

resource "aws_security_group_rule" "contacts_sg_rule_alb" {
  #for_each = var.adaptor
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.wrapper_sg["contacts"].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "contacts_sg_rule_private" {
  #for_each                  = var.adaptor
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.wrapper_sg["contacts"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "contacts_sg_rule_rds" {
  #for_each                  = var.adaptor
  source_security_group_id  = var.security_groups_rds_contact
  security_group_id         = aws_security_group.wrapper_sg["contacts"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "contacts_sg_rule_redis" {
  #for_each                  = var.adaptor
  security_group_id         = aws_security_group.wrapper_sg["contacts"].id
  source_security_group_id  = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}


#Configuration_API security group configuration:
#==========================================

resource "aws_security_group_rule" "configuration_sg_rule_alb" {
  #for_each = var.adaptor
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.wrapper_sg["configurations"].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "configuration_sg_rule_private" {
  #for_each                  = var.adaptor
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.wrapper_sg["configurations"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "configuration_sg_rule_rds" {
  #for_each                  = var.adaptor
  source_security_group_id  = var.security_groups_rds_configuration
  security_group_id         = aws_security_group.wrapper_sg["configurations"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "configuration_sg_rule_redis" {
  #for_each                  = var.adaptor
  security_group_id         = aws_security_group.wrapper_sg["configurations"].id
  source_security_group_id  = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}


#Organisation_API security group configuration:
#==========================================

resource "aws_security_group_rule" "organisation_sg_rule_alb" {
  #for_each = var.adaptor
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.wrapper_sg["organisations"].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "organisation_sg_rule_private" {
  #for_each                  = var.adaptor
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.wrapper_sg["organisations"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "organisation_sg_rule_rds" {
  #for_each                  = var.adaptor
  source_security_group_id  = var.security_groups_rds_organisation
  security_group_id         = aws_security_group.wrapper_sg["organisations"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "organisation_sg_rule_redis" {
  #for_each                  = var.adaptor
  security_group_id         = aws_security_group.wrapper_sg["organisations"].id
  source_security_group_id  = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}


#User_API security group configuration:
#==========================================

resource "aws_security_group_rule" "user_sg_rule_alb" {
  #for_each = var.adaptor
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.wrapper_sg["users"].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "user_sg_rule_private" {
  #for_each                  = var.adaptor
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.wrapper_sg["users"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "user_sg_rule_rds" {
  #for_each                  = var.adaptor
  source_security_group_id  = var.security_groups_rds_user
  security_group_id         = aws_security_group.wrapper_sg["users"].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "user_sg_rule_redis" {
  #for_each                  = var.adaptor
  security_group_id         = aws_security_group.wrapper_sg["users"].id
  source_security_group_id  = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}



#validation & Notification security group configuration:
#======================================================

resource "aws_security_group_rule" "validation_sg_rule_alb" {
  for_each = var.validation
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.validation_sg[each.key].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "validation_private_sg_rule" {
  for_each                  = var.validation
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.validation_sg[each.key].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}


#testmvc & saml-mvc security group configuration:
#======================================================

resource "aws_security_group_rule" "demo_mvc_sg_rule_alb" {
  for_each = var.testmvc
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.testmvc_sg[each.key].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_security_group_rule" "demomvc_private_sg_rule" {
  for_each                  = var.testmvc
  cidr_blocks               = ["10.0.0.0/16"]
  security_group_id         =  aws_security_group.testmvc_sg[each.key].id
  description               = "Allow Private Ips for all the services"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

#utility service sg rule

resource "aws_security_group_rule" "utility_sg_rule_alb" {
  for_each = var.utility
  source_security_group_id  = var.security_groups_backend
  security_group_id         =  aws_security_group.utility_sg[each.key].id
  description               = "Allow All inwards to ecs from clients"
  from_port                 = 0
  protocol                  = -1
  to_port                   = 0
  type                      = "ingress"
}

#Security DB security group configuration
#========================================

resource "aws_security_group_rule" "security_sg_rds_rule" {
  for_each = var.security
  source_security_group_id  = aws_security_group.security_sg[each.key].id 
  security_group_id         = var.security_groups_rds_security
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "bastion_security_sg_rds_rule" {
  for_each = var.security
  source_security_group_id  = var.security_groups_bastion
  security_group_id         = var.security_groups_rds_security
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}


#Adaptor DB security group configuration
#========================================


resource "aws_security_group_rule" "adaptor_sg_rds_rule" {
  for_each = var.adaptor
  source_security_group_id  = aws_security_group.adaptor_sg[each.key].id
  security_group_id         = var.security_groups_rds_adaptor 
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      =  "ingress"
}

resource "aws_security_group_rule" "bastion_adaptor_sg_rds_rule" {
  for_each = var.security
  source_security_group_id  = var.security_groups_bastion
  security_group_id         = var.security_groups_rds_adaptor
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}


#Core & Wrapper DB security group configuration
#===============================================


resource "aws_security_group_rule" "orgderegjob_sg_rds_rule" {
  #for_each = var.jobs
  source_security_group_id  = aws_security_group.job_sg["org-dereg-job"].id
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "migrationjob_config_sg_rds_rule" {
  #for_each = var.jobs
  source_security_group_id  = aws_security_group.job_sg["data-migration-configuration"].id
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "migrationjob_contact_sg_rds_rule" {
  #for_each = var.jobs
  source_security_group_id  = aws_security_group.job_sg["data-migration-contact"].id
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "migrationjob_org_sg_rds_rule" {
  #for_each = var.jobs
  source_security_group_id  = aws_security_group.job_sg["data-migration-organisation"].id
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "migrationjob_user_sg_rds_rule" {
  #for_each = var.jobs
  source_security_group_id  = aws_security_group.job_sg["data-migration-user"].id
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "reportingjob_sg_rds_rule" {
  #for_each = var.jobs
  source_security_group_id  = aws_security_group.job_sg["reporting-job"].id
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "dashboadwrapper_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.wrapper_sg["dashboard-wrapper"].id
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "wrapper_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.wrapper_sg["wrapper"].id
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}


resource "aws_security_group_rule" "delegation_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.job_sg["delegation-job"].id
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}


resource "aws_security_group_rule" "bastion_wrapper_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = var.security_groups_bastion
  security_group_id         = var.security_groups_rds_wrapper
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}


#User DB security group configuration
#=====================================

resource "aws_security_group_rule" "user_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.wrapper_sg["users"].id
  security_group_id         = var.security_groups_rds_user
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "coredb_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = var.security_groups_rds_wrapper
  security_group_id         = var.security_groups_rds_user
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "bastion_user_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = var.security_groups_bastion
  security_group_id         = var.security_groups_rds_user
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "db_user_to_org_sg" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.job_sg["data-migration-organisation"].id
  security_group_id         = var.security_groups_rds_user
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "db_user_to_contact_sg" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.job_sg["data-migration-contact"].id
  security_group_id         = var.security_groups_rds_user
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}



#Contact DB security group configuration
#========================================

resource "aws_security_group_rule" "contact_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.wrapper_sg["contacts"].id
  security_group_id         = var.security_groups_rds_contact
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "coredb_contact_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = var.security_groups_rds_wrapper
  security_group_id         = var.security_groups_rds_contact
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "bastion_contact_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = var.security_groups_bastion
  security_group_id         = var.security_groups_rds_contact
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "db_contact_to_user_sg" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.job_sg["data-migration-user"].id
  security_group_id         = var.security_groups_rds_contact
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "db_contact_to_org_sg" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.job_sg["data-migration-organisation"].id
  security_group_id         = var.security_groups_rds_contact
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}



#Configurations DB security group configuration
#==============================================

resource "aws_security_group_rule" "config_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.wrapper_sg["configurations"].id
  security_group_id         = var.security_groups_rds_configuration
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "coredb_config_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = var.security_groups_rds_wrapper
  security_group_id         = var.security_groups_rds_configuration
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "bastion_config_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = var.security_groups_bastion
  security_group_id         = var.security_groups_rds_configuration
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}


#Organisation DB security group configuration
#=====================================

resource "aws_security_group_rule" "org_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.wrapper_sg["organisations"].id
  security_group_id         = var.security_groups_rds_organisation
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "coredb_org_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = var.security_groups_rds_wrapper
  security_group_id         = var.security_groups_rds_organisation
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "bastion_org_sg_rds_rule" {
  #for_each = var.wrapper
  source_security_group_id  = var.security_groups_bastion
  security_group_id         = var.security_groups_rds_organisation
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "db_org_to_user_sg" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.job_sg["data-migration-user"].id
  security_group_id         = var.security_groups_rds_organisation
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "db_org_to_contact_sg" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.job_sg["data-migration-contact"].id
  security_group_id         = var.security_groups_rds_organisation
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

resource "aws_security_group_rule" "db_org_to_config_sg" {
  #for_each = var.wrapper
  source_security_group_id  = aws_security_group.job_sg["data-migration-configuration"].id
  security_group_id         = var.security_groups_rds_organisation
  description               = "Allow 5432 inwards to ecs from clients"
  from_port                 = 5432
  protocol                  = "tcp"
  to_port                   = 5432
  type                      = "ingress"
}

#Security Redis Security group configuration:
#============================================

resource "aws_security_group_rule" "security_sg_redis_rule" {
  for_each = var.security
  source_security_group_id  = aws_security_group.security_sg[each.key].id 
  security_group_id         = var.security_groups_redis_security
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}

#Data Redis Security group configuration:
#============================================

resource "aws_security_group_rule" "wrapper_sg_redis_rule" {
  for_each = var.wrapper
  source_security_group_id  = aws_security_group.wrapper_sg[each.key].id
  security_group_id         = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}

resource "aws_security_group_rule" "adaptor_sg_redis_rule" {
  for_each = var.adaptor
  source_security_group_id  = aws_security_group.adaptor_sg[each.key].id
  security_group_id         = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}


resource "aws_security_group_rule" "jobs_sg_redis_rule" {
  for_each = var.jobs
  source_security_group_id  = aws_security_group.job_sg[each.key].id
  security_group_id         = var.security_groups_redis_data
  description               = "Allow 6379 inwards to ecs from clients"
  from_port                 = 6379
  protocol                  = "tcp"
  to_port                   = 6379
  type                      = "ingress"
}


#Security Group rules to enable Backend service port to [10.0.0.0/16] Ip range for Jobs
#=====================================================================================

resource "aws_security_group_rule" "jobs_sg_rule" {
  for_each = var.jobs
  #source_security_group_id = var.security_groups_backend
  cidr_blocks = ["10.0.0.0/16"]
  security_group_id =  aws_security_group.job_sg[each.key].id
  description       = "Allow 5000 inwards to ecs from clients"
  from_port                = 5000
  protocol                 = "tcp"
  to_port                  = 5000
  type                     = "ingress"
}

#Security Group rules to enable the DB acces for the Datamigration - config job
#=============================================================================

resource "aws_security_group_rule" "job_data_migration_sg_rule_configuration" {
  security_group_id =  aws_security_group.job_sg["data-migration-configuration"].id
  source_security_group_id = var.security_groups_rds_configuration
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_config_sg_rule_coredb" {
  security_group_id =  aws_security_group.job_sg["data-migration-configuration"].id
  source_security_group_id = var.security_groups_rds_wrapper
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}


#Security Group rules to enable the DB acces for the Datamigration-contact job
#============================================================================

resource "aws_security_group_rule" "job_data_migration_sg_rule_contacts" {
  security_group_id =  aws_security_group.job_sg["data-migration-contact"].id
  source_security_group_id = var.security_groups_rds_contact
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_contact_sg_rule_coredb" {
  security_group_id =  aws_security_group.job_sg["data-migration-contact"].id
  source_security_group_id = var.security_groups_rds_wrapper
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_contact_sg_rule_organisation" {
  security_group_id =  aws_security_group.job_sg["data-migration-contact"].id
  source_security_group_id = var.security_groups_rds_organisation
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_contact_sg_rule_users" {
  security_group_id =  aws_security_group.job_sg["data-migration-contact"].id
  source_security_group_id = var.security_groups_rds_user
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}


#Security Group rules to enable the DB acces for the Datamigration-org job
#============================================================================

resource "aws_security_group_rule" "job_data_migration_sg_rule_organisation" {
  security_group_id =  aws_security_group.job_sg["data-migration-organisation"].id
  source_security_group_id = var.security_groups_rds_organisation
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_org_sg_rule_coredb" {
  security_group_id =  aws_security_group.job_sg["data-migration-organisation"].id
  source_security_group_id = var.security_groups_rds_wrapper
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_org_sg_rule_userdb" {
  security_group_id =  aws_security_group.job_sg["data-migration-organisation"].id
  source_security_group_id = var.security_groups_rds_user
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_org_sg_rule_contactdb" {
  security_group_id =  aws_security_group.job_sg["data-migration-organisation"].id
  source_security_group_id = var.security_groups_rds_contact
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}


#Security Group rules to enable the DB acces for the Datamigration-User job
#============================================================================

resource "aws_security_group_rule" "job_data_migration_sg_rule_users" {
  security_group_id =  aws_security_group.job_sg["data-migration-user"].id
  source_security_group_id = var.security_groups_rds_user
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_user_sg_rule_coredb" {
  security_group_id =  aws_security_group.job_sg["data-migration-user"].id
  source_security_group_id = var.security_groups_rds_wrapper
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_user_sg_rule_orgdb" {
  security_group_id =  aws_security_group.job_sg["data-migration-user"].id
  source_security_group_id = var.security_groups_rds_organisation
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_user_sg_rule_contactdb" {
  security_group_id =  aws_security_group.job_sg["data-migration-user"].id
  source_security_group_id = var.security_groups_rds_contact
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

#=========================

resource "aws_security_group_rule" "job_data_migration_sg_rule_config" {
  source_security_group_id = aws_security_group.job_sg["data-migration-configuration"].id
  security_group_id = var.security_groups_rds_configuration
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}


resource "aws_security_group_rule" "job_data_migration_sg_rule_contact" {
  source_security_group_id = aws_security_group.job_sg["data-migration-contact"].id
  security_group_id = var.security_groups_rds_contact
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_sg_rule_org" {
  source_security_group_id = aws_security_group.job_sg["data-migration-organisation"].id
  security_group_id = var.security_groups_rds_organisation
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

resource "aws_security_group_rule" "job_data_migration_sg_rule_user" {
  source_security_group_id = aws_security_group.job_sg["data-migration-user"].id
  security_group_id = var.security_groups_rds_user
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

#security group rule for ppon job
#==================================
resource "aws_security_group_rule" "ppon_job_sg_rule_configuration" {
  security_group_id =  aws_security_group.job_sg["ppon-job-ms"].id
  source_security_group_id = var.security_groups_rds_wrapper
  description       = "Allow 5432 inwards to ecs from clients"
  from_port                = 5432
  protocol                 = "tcp"
  to_port                  = 5432
  type                     = "ingress"  
}

#bastion_host_sg:
#================

# resource "aws_security_group_rule" "postgres_sg_rule_alb" {
#   #for_each = var.adaptor
#   source_security_group_id  = var.security_groups_backend
#   security_group_id         =  var.security_groups_bastion
#   description               = "Allow All inwards to ecs from clients"
#   from_port                 = 0
#   protocol                  = -1
#   to_port                   = 0
#   type                      = "ingress"
# }

