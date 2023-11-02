module "vpc" {
  source                          = "../modules/vpc"
  name                            = var.name
  cidr                            = var.cidr
  private_subnets                 = var.private_subnets
  public_subnets                  = var.public_subnets
  availability_zones              = var.availability_zones
  environment                     = var.environment
}

module "s3" {
  source                          = "../modules/s3"
  bucket_name                     = var.bucket_name
  versioning                      = true
  env                             = var.env
}

module "sqs" {
  source                          = "../modules/sqs"
  queue_names                     = var.queuenames
}

module "rds" {
  source                          = "../modules/rds"
  for_each                        = toset(var.rds_apps)
  engine                          = "postgres"
  instance_type                   = "db.m5.2xlarge"
  allocated_storage               = 150
  db_indentifier                  = "${var.env}-${each.key}-pg-service"
  database_name                   = "${var.database_name}_${each.key}"
  database_user                   = var.database_user
  env                             = var.env 
  database_port                   = var.database_port
  engine_version                  = "14.7"
  max_allocated_storage           = 150
  storage_encrypted               = true
  availability_zone               = var.database_az
  private_subnets                 = [module.vpc.private_1, module.vpc.private_2, module.vpc.private_3]
  skip_final_snapshot             = var.skip_final_snapshot
  vpc_id                          = module.vpc.id
  rds_instances                   = [each.key]
  db_connection_url               = "${each.key}-connection-string"
  iam_role_arn                    = module.iam.ecs_task_execution_role_arn
}


module "redis" {
  source                          = "../modules/redis"
  for_each                        = toset(var.redis_apps)
  cluster_id                      = "${var.env}-${each.key}-redis"
  engine_version                  = var.engine_version
  node_type                       = var.node_type
  num_cache_nodes                 = var.num_cache_nodes
  env                             = var.env
  private_subnets                 = [module.vpc.private_1, module.vpc.private_2, module.vpc.private_3]
  vpc_id                          = module.vpc.id
}

module "ecr" {
  source                          = "../modules/ecr"
  env                             = var.env
  ecr_repositories                = var.ecr_repositories
}

module "iam" {
  source                          = "../modules/iam"
  environment                     = var.environment
  env                             = var.env
  region                          = var.region
  bucket_name                     = var.bucket_name
  startup_url                     = "http://0.0.0.0:5000"
  account                         = var.account
}

module "alb" {
  source                            = "../modules/alb"
  env                               = var.env
  subnet_ids                        = [module.vpc.public_1, module.vpc.public_2, module.vpc.public_3]
  vpc_id                            = module.vpc.id
  health_check_path                 = var.health_check_path
  health_check_path_bk              = var.health_check_path_bk
  app_port                          = var.app_port
  target_group_arn_security         = module.ecs.target_group_arn_security
  target_group_arn_adaptor          = module.ecs.target_group_arn_adaptor
  target_group_arn_dashboardwrapper = module.ecs.target_group_arn_dashboardwrapper
  target_group_arn_wrapper          = module.ecs.target_group_arn_wrapper
  target_group_arn_configurations   = module.ecs.target_group_arn_configurations
  target_group_arn_organisations    = module.ecs.target_group_arn_organisations
  target_group_arn_users            = module.ecs.target_group_arn_users
  target_group_arn_contacts         = module.ecs.target_group_arn_contacts
  target_group_arn_buyervalidation  = module.ecs.target_group_arn_buyervalidation
  target_group_arn_notification     = module.ecs.target_group_arn_notification
  target_group_arn_demo_mvc         = module.ecs.target_group_arn_demo_mvc
  target_group_arn_demo_mvc_saml    = module.ecs.target_group_arn_demo_mvc_saml
  target_group_arn_ssm_api          = module.ecs.target_group_arn_ssm_api
  target_group_arn_bastion          = module.alb.postgres-tg_arn 
  certificate_arn                   = var.certificate_arn
  certificate_arn_backend           = var.certificate_arn_backend
  instance_id                       = module.bastion_host.bastion_instance_id
  use_https                         = var.use_https
}


module "ecs" {
  source                            = "../modules/ecs"
  aws_region                        = var.region
  ecs_task_execution_role           = module.iam.ecs_task_execution_role_arn
  environment                       = var.environment
  org                               = var.name
  env                               = var.env
  app_port                          = var.app_port
  web_port                          = var.web_port
  app_count_security                = "5"
  app_count_adaptor                 = "5"
  app_count_wrapper                 = "5"
  app_count_validation              = "5"
  app_count_testmvc                 = "1"
  app_count_jobs                    = "1"
  app_count_frontend                = "5"
  app_count_utility                 = "1"    
  fargate_cpu                       = var.fargate_cpu
  fargate_memory                    = var.fargate_memory
  web                               = var.web
  security                          = var.security
  adaptor                           = var.adaptor
  wrapper                           = var.wrapper
  validation                        = var.validation
  testmvc                           = var.testmvc
  jobs                              = var.jobs
  utility                           = var.utility
  target_group_arn_frontend         = module.alb.frontend-tg_arn
  subnets                           = [module.vpc.private_1, module.vpc.private_2, module.vpc.private_3]
  subnet_ids                        = [module.vpc.public_1, module.vpc.public_2]
  security_groups_frontend          = module.alb.alb-frontend-sg_id
  security_groups_backend           = module.alb.alb-backend-sg_id
  security_groups_rds_security      = module.rds["security"].db_security_group_id
  security_groups_rds_adaptor       = module.rds["adaptor"].db_security_group_id
  security_groups_rds_wrapper       = module.rds["sso"].db_security_group_id
  security_groups_rds_user          = module.rds["user"].db_security_group_id
  security_groups_rds_configuration = module.rds["configuration"].db_security_group_id
  security_groups_rds_contact       = module.rds["contact"].db_security_group_id
  security_groups_rds_organisation  = module.rds["organisation"].db_security_group_id
  security_groups_redis_data        = module.redis["data"].cluster_security_group_id
  security_groups_redis_security    = module.redis["security"].cluster_security_group_id
  security_groups_bastion           = module.bastion_host.bastion-sg_id
  account                           = var.account
  alb_frontend                      = module.alb.alb_frontend
  alb_backend                       = module.alb.alb_backend
  vpc_id                            = module.vpc.id
  health_check_path_bk              = var.health_check_path_bk
}

module "cw" {
  source                            = "../modules/cw"
  create                            = true
  retention_in_days                 = 0
  env                               = var.env
  web                               = var.web
  security                          = var.security
  adaptor                           = var.adaptor
  wrapper                           = var.wrapper
  validation                        = var.validation
  jobs                              = var.jobs
  testmvc                           = var.testmvc
  utility                           = var.utility
}


module "bastion_host" {
  source                            = "../modules/bastion"
  ami                               = var.ami
  instance_type                     = var.instance_type
  key_name                          = var.key_name
  instance_name                     = var.instance_name
  subnet_id                         = module.vpc.public_2
  security_group_name               = "${var.env}-bastion-sg"
  vpc_id                            = module.vpc.id
  #availability_zones = var.availability_zones
  vpc_public_subnets                = [module.vpc.public_1]
  target_group_arn_bastion          = [module.alb.postgres-tg_arn]
  alb_backend_sg_id                 = module.alb.alb-backend-sg_id
}