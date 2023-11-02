variable "engine" {
  description = "Database engine (e.g., mysql, postgresql, etc.)"
  type        = string
}

variable "db_connection_url" {
  description = "DB connection url fro rds"
  type        = string
}

variable "db_indentifier" {
  description = "DB instance name"
  type        = string
}

variable "rds_instances" {
  type    = list(string)
  description = "List of rds db instance names"
  default = ["security", "adaptor", "organisation", "user", "configuration", "contact", "coredb"]
}

variable "env" {
  description = "docker image to run in this ECS cluster"
}

variable "instance_type" {
  description = "RDS instance type"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for the RDS instance (in GB)"
  type        = number
}

variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "database_user" {
  description = "Username for the database"
  type        = string
}

# variable "database_password" {
#   description = "Password for the database"
#   type        = string
# }

variable "database_port" {
  description = "Port for the database"
  type        = number
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage for the RDS instance (in GB)"
  type        = number
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Enable storage encryption"
  type        = bool
}

variable "availability_zone" {
  description = "Availability zone for the RDS instance"
  type        = list(string)
}


variable "private_subnets" {
  description = "List of private subnets"
  type    = set(string)
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC containing the service"
}

variable "iam_role_arn" {
  type        = string
  description = "iam_role_arn"
}