variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}


variable "versioning" {
  type        = bool
  description = "If set to true, will activate versioning on all objects placed in the bucket"
  default     = true
}

variable "env" {
  description = "Name of the S3 bucket"
  type        = string
}
