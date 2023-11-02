variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "env" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "region" {
  description = "mention the region"
  default = "eu-west-2"
}

variable "startup_url" {
  description = "startup URL for the application"
  default = "http://0.0.0.0:5000"

}

variable "bucket_name" {
  description = "Bucket name to allow access"
}

variable "account" {
  description = "Bucket name to allow access"
}
