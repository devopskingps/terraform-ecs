variable "name" {
  description = "the name of your stack, e.g. \"demo\""
  default = ""
}

variable "certificate_arn" {
  type = string
}

variable "certificate_arn_backend" {
  type = string
}


variable "ami" {
  description = "AMI ID for the ECS Bastion Host"
  type        = string
  default = ""
}

variable "instance_type" {
  description = "Instance type for the ECS Bastion Host"
  type        = string
  default = ""
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default = ""
}

variable "instance_name" {
  description = "Name tag for the ECS Bastion Host"
  type        = string
  default = ""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = ""
}

variable "region" {
  description = "the name of your environment, e.g. \"prod\""
  default     = ""
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = []
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = ""
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = []
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = []
}

variable "container_port" {
  description = "The port where the Docker is exposed"
  default     = 80
}


variable "bucket_name" {
  description = "name of the bucket to be created"
  default     = ""
}

variable "queuenames" {
  description = "Queues to be creted"
  type = list(string)
  default     = []
}

variable "database_name" {
  description = "database_name"
  type        = string
  default = ""
}

variable "database_user" {
  description = "database_user"
  type        = string
  default = ""
}

# variable "database_password" {
#   description = "database_password"
#   type        = string
#   default = ""
# }

variable "rds_apps" {
  type    = list(string)
  description = "List of queue names"
}

variable "redis_apps" {
  type    = list(string)
  description = "List of queue names"
}


variable "database_port" {
  description = "database_port"
  type        = string
  default = ""
}

variable "database_az" {
  description = "database_port"
  type        = list(string)
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "az_count" {
  default     = ""
  description = "number of availability zones in above region"
}

variable "container_cpu" {
  type        = number
  description = "CPU to allocate to each task container (where a value of 1024 == 1vCPU)"
  default = 1024
}

variable "container_memory" {
  type        = number
  description = "CPU to allocate to each task container (where a value of 1024 == 1vCPU)"
  default = 1024
}

variable "node_count" {
  description = "node_count"
  type        = string
  default = ""
}

variable "redis_port" {
  description = "node_count"
  type        = string
  default = ""
}


variable "account" {
  description = "id for the account"
  type = string
  default = ""
}

variable "skip_final_snapshot" {
  description = "Enable storage encryption"
  type        = bool
  default = true
}

variable "env" {
  description = "the name of your environment, e.g. \"if production -- mention as prod\""
  type = string
  default = ""
}

# variable "app_image" {
#   default     = "nginx:latest"
#   description = "docker image to run in this ECS cluster"
# }

variable "app_port" {
  default     = ""
  description = "portexposed on the docker image"
}

variable "web_port" {
  description = "portexposed on the docker image"
  default     = ""
}



variable "app_count" {
  default     = "2" #choose 2 bcz i have choosen 2 AZ
  description = "numer of docker containers to run"
}
variable "health_check_path" {
  default = "/"
}

variable "health_check_path_bk" {
  default = "/swagger/index.html"
}

variable "fargate_cpu" {
  default     = "1024"
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "fargate_memory" {
  default     = "2048"
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "web" {
  type = map(object({
    env           = string
    account        = string
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
  }))
  default = {
    angular = {
      account        = ""
      env            = "dev"
      app_name       = "angular"
      app_image      = "angular:latest"
      app_port       = 80
      fargate_cpu    = "256"
      fargate_memory = "512"
    }
  }
}

# variable "web" {
#   type = map(object({
#     app_name      = string
#     app_image      = string
#     app_port       = number
#     fargate_cpu    = string
#     fargate_memory = string
#     account       = string
#     env           = string
#   }))
# }


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
  default = {
    security = {
      account        = ""
      env            = ""
      app_name       = "security"
      app_image      = "security:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
  }
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
  default = {
    adaptor = {
      account        = ""
      env            = ""
      app_name       = "adaptor"
      app_image      = "adaptor:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
  }
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
  default = {
    dashboard-wrapper = {
      account        = ""
      env            = ""
      app_name       = "dashboardwrapper"
      app_image      = "dashboardwrapper:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    wrapper = {
      account        = ""
      env            = ""
      app_name       = "wrapper"
      app_image      = "wrapper:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    user-profile = {
      account        = ""
      env            = ""
      app_name       = "users"
      app_image      = "users:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    configurations = {
      account        = ""
      env            = ""
      app_name       = "configurations"
      app_image      = "configurations:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    organisation-profile = {
      account        = ""
      env            = ""
      app_name       = "organisations"
      app_image      = "organisations:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    contacts = {
      account        = ""
      env            = ""
      app_name       = "contacts"
      app_image      = "contacts:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
  }
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
    default = {
    buyervalidation = {
      account        = ""
      env            = ""
      app_name       = "buyervalidation"
      app_image      = "buyervalidation:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    notification = {
      account        = ""
      env            = ""
      app_name       = "notification"
      app_image      = "notification:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
  }
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
    default = {
    demo-mvc = {
      account        = ""
      env            = ""
      app_name       = "demo-mvc"
      app_image      = "demo-mvc:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    demo-mvc-saml = {
      account        = ""
      env            = ""
      app_name       = "demo-mvc-saml"
      app_image      = "demo-mvc-saml:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
  }
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
    default = {
    ssm-api = {
      account        = ""
      env            = ""
      app_name       = "ssm-api"
      app_image      = "ssm-api:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
  }
}

variable "jobs" {
  type = map(object({
    env           = string
    app_name      = string
    app_image      = string
    app_port       = number
    fargate_cpu    = string
    fargate_memory = string
    account        = string
  }))
  default = {
    adaptor-sqs-listener = {
      account        = ""
      env            = ""
      app_name       = "adaptor-sqs-listener"
      app_image      = "adaptor-sqs-listener:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    org-dereg-job = {
      account        = ""
      env            = ""
      app_name       = "org-dereg-job"
      app_image      = "org-dereg-job:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    reporting-job = {
      account        = ""
      env            = ""
      app_name       = "reporting-job"
      app_image      = "reporting-job:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    ppon-job-ms = {
      account        = ""
      env            = ""
      app_name       = "ppon-job-ms"
      app_image      = "ppon-job-ms:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    delegation-job = {
      account        = ""
      env            = ""
      app_name       = "delegation-job"
      app_image      = "delegation-job:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    data-migration-configuration = {
      account        = ""
      env            = ""
      app_name       = "data-migration-configuration"
      app_image      = "data-migration-configuration:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    data-migration-contact = {
      account        = ""
      env            = ""
      app_name       = "data-migration-contact"
      app_image      = "data-migration-contact:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    data-migration-organisation = {
      account        = ""
      env            = ""
      app_name       = "data-migration-organisation"
      app_image      = "data-migration-organisation:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
    data-migration-user = {
      account        = ""
      env            = ""
      app_name       = "data-migration-user"
      app_image      = "data-migration-user:latest"
      app_port       = 5000
      fargate_cpu    = "512"
      fargate_memory = "1024"
    }
  }
}

variable "ecr_repositories" {
  type = map(object({
    name         = string
    image_tag_mutability = string
    scan_on_push = bool
  }))
  default = {
    security = {
      name                  = "security"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    dashboardwrapper = {
      name                  = "core"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    adaptor = {
      name                  = "adaptor"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    wrapper = {
      name                  = "wrapper"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    adaptor-sqs-listener = {
      name                  = "adaptor-sqs-listener"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    org-dereg-job = {
      name                  = "org-dereg-job"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    angular = {
      name                  = "angular"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    buyervalidation = {
      name                  = "buyervalidation"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    notification = {
      name                  = "notification"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    users = {
      name                  = "users"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    contacts = {
      name                  = "contacts"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    configurations = {
      name                  = "configurations"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    organisations = {
      name                  = "organisations"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    reporting-job = {
      name                  = "reporting-job"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    ppon-job-ms = {
      name                  = "ppon-job-ms"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    delegation-job = {
      name                  = "delegation-job"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    data-migration-configuration = {
      name                  = "data-migration-configuration"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    data-migration-contact = {
      name                  = "data-migration-contact"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    data-migration-organisation = {
      name                  = "data-migration-organisation"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    data-migration-user = {
      name                  = "data-migration-user"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    demo-mvc = {
      name                  = "demo-mvc"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    demo-mvc-saml = {
      name                  = "demo-mvc-saml"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    },
    ssm-api = {
      name                  = "ssm-api"
      image_tag_mutability  = "MUTABLE"
      scan_on_push          = false
    }
  }
}

variable "cluster_id" {
  type        = string
  description = "ID (name) to give"
  validation {
    condition     = can(regex("[a-z0-9\\-]+", var.cluster_id))
    error_message = "The cluster_id can only contain lower case a-z, 0-9 and hyphens(-)"
  }
  default = ""
}

variable "engine_version" {
  type        = string
  description = "Version of Redis engine"
  default     = "6.2"
}

variable "node_type" {
  type        = string
  description = "Type of node to deploy for the cachr"
  default     = "cache.t2.small"
}

variable "num_cache_nodes" {
  type        = number
  description = "Number of cache nodes to instantiate"
  default     = 1
}


# variable "vpc_id" {
#   type        = string
#   description = "ID of the VPC containing the service"
#   default = ""
# }

# variable "alb_frontend_sg_id" {
#   type = set(string)
#   default = []
# }

# variable "alb_backend_sg_id" {
#   type = set(string)
#   default = []
# }

variable "use_https" {
  type = bool  
}

# variable "iam_role_arn" {
#   type        = string
#   description = "iam_role_arn"
# }