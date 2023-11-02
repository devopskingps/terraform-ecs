variable "ecr_repositories" {
  type = map(object({
    name         = string
    image_tag_mutability = string
    scan_on_push = bool
  }))
}

variable "env" {
  description = "the name of your environment, e.g. \"if production -- mention as prod\""
  type = string
}
