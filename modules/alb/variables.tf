variable "env" {
  description = "docker image to run in this ECS cluster"
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "vpc_id" {
  type = string
}

variable "instance_id" {
  type = string
}

variable "health_check_path" {
  description = "health check port for frontend tg"
}

variable "app_port" {
  description = "portexposed on the docker image"
}

variable "health_check_path_bk" {
    description = "health check port for backend tg"
}


variable "target_group_arn_security" {
  type = string
}


variable "target_group_arn_dashboardwrapper" {
  type = string
}

variable "target_group_arn_adaptor" {
  type = string
}

variable "target_group_arn_organisations" {
  type = string
}

variable "target_group_arn_configurations" {
  type = string
}

variable "target_group_arn_users" {
  type = string
}

variable "target_group_arn_contacts" {
  type = string
}

variable "target_group_arn_buyervalidation" {
  type = string
}

variable "target_group_arn_notification" {
  type = string
}

variable "target_group_arn_wrapper" {
  type = string
}

variable "target_group_arn_demo_mvc_saml" {
  type = string
}

variable "target_group_arn_bastion" {
  type = string
}

variable "target_group_arn_demo_mvc" {
  type = string
}

variable "target_group_arn_ssm_api" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "certificate_arn_backend" {
  type = string
}

variable "use_https" {
  type = bool  
}

