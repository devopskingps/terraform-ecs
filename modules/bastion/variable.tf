# ecs-bastion/variables.tf

variable "ami" {
  description = "AMI ID for the ECS Bastion Host"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the ECS Bastion Host"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "security_group_name" {
  description = "security group name for ec2_bastion_host"
  type        = string
}

variable "vpc_id" {
  description = "vpc id to create the ec2 instance"
  type        = string
}

variable "target_group_arn_bastion" {
  description = "target_group_arn_bastion"
  type        = set(string)
}

variable "vpc_public_subnets" {
  description = "public subnets of the vpc"
  type        = set(string)
}

variable "subnet_id" {
  type    = string
}

variable "instance_name" {
  description = "Name tag for the ECS Bastion Host"
  type        = string
}

variable "alb_backend_sg_id" {
  description = "var.alb_backend_sg_id"
  type        = string
}

# variable "availability_zones" {
#   description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
#   default     = []
# }