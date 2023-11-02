variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  type        = bool
  default     = true
}

variable "queue_names" {
  type    = list(string)
  description = "List of queue names"
}