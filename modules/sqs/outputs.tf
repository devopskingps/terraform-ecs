output "sqs_queue_urls" {
  value = [for queue_name in var.queue_names : aws_sqs_queue.sqs_queue[queue_name].id]
}
