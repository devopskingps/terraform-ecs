variable "security_groups_frontend" {
  type = string
}

variable "security_groups_backend" {
  type = string
}

variable "security_groups_rds_security" {
  type = string
}

variable "security_groups_rds_adaptor" {
  type = string
}

variable "security_groups_rds_wrapper" {
  type = string
}

variable "security_groups_rds_user" {
  type = string
}
variable "security_groups_rds_organisation" {
  type = string
}
variable "security_groups_rds_configuration" {
  type = string
}
variable "security_groups_rds_contact" {
  type = string
}
variable "security_groups_redis_security" {
  type = string
}

variable "security_groups_redis_data" {
  type = string
}

variable "security_groups_bastion" {
  type = string
}

variable "account" {
  description = "id for the account"
  type = string
}

variable "subnets" {
  type = set(string)
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "aws_region" {
  description = "aws region where our resources going to create choose"
}

variable "ecs_task_execution_role" {
  description = "ECS task execution role name"
}

variable "environment" {
  description = "docker image to run in this ECS cluster"
}

variable "org" {
  description = "organisation"
}

variable "env" {
  description = "docker image to run in this ECS cluster"
}

variable "app_port" {
  description = "portexposed on the docker image"
}

variable "web_port" {
  description = "portexposed on the docker image"
}

# variable "health_check_path" {
#   description = "health_check_path"
# }

variable "app_count_security" {
  description = "numer of docker containers to run"
}

variable "app_count_wrapper" {
  description = "numer of docker containers to run"
}

variable "app_count_adaptor" {
  description = "numer of docker containers to run"
}

variable "app_count_validation" {
  description = "numer of docker containers to run"
}

variable "app_count_testmvc" {
  description = "numer of docker containers to run"
}

variable "app_count_jobs" {
  description = "numer of docker containers to run"
}

variable "app_count_frontend" {
  description = "numer of docker containers to run"
}

variable "app_count_utility" {
  description = "numer of docker containers to run"
}

variable "fargate_cpu" {
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "target_group_arn_frontend" {
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "health_check_path_bk" {
    description = "health check port for backend tg"
}

variable "ecs_as_cpu_low_threshold_per" {
  default = "20"
}

variable "ecs_as_cpu_high_threshold_per" {
  default = "80"
}

# The minimum number of containers that should be running.
# Must be at least 1.
variable "ecs_autoscale_min_instances" {
  default = "3"
}

# The maximum number of containers that should be running.
variable "ecs_autoscale_max_instances" {
  default = "10"
}


variable "web" {
  type = map(object({
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
    account       = string
    env           = string
  }))
}


variable "security" {
  type = map(object({
    account       = string
    env           = string
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
  }))
}

variable "adaptor" {
  type = map(object({
    account       = string
    env           = string
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
  }))
}

variable "wrapper" {
  type = map(object({
    account       = string
    env           = string
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
  }))
}


variable "validation" {
  type = map(object({
    account       = string
    env           = string
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
  }))
}

variable "testmvc" {
  type = map(object({
    account       = string
    env           = string
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
  }))
}

variable "utility" {
  type = map(object({
    account       = string
    env           = string
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
  }))
}

variable "jobs" {
  type = map(object({
    account       = string
    env           = string
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
  }))
}

variable "alb_frontend" {
  description = "Frontend value from the ALB module"
  type        = string
}

variable "alb_backend" {
  description = "Backend value from the ALB module"
  type        = string
}

variable "vpc_id" {
  type = string
}
