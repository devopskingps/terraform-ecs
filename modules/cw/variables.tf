variable "create" {
  description = "Whether to create the Cloudwatch log group"
  type        = bool
  default     = true
}

variable "env" {
  description = "the name of your environment, e.g. \"if production -- mention as prod\""
  type = string
}


variable "retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
  type        = number
  default     = null

  validation {
    condition     = var.retention_in_days == null ? true : contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653], var.retention_in_days)
    error_message = "Must be 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653 or 0 (zero indicates never expire logs)."
  }
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

