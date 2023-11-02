resource "aws_sqs_queue" "sqs_queue" {
  for_each = toset(var.queue_names)
  fifo_queue = var.fifo_queue
  name = each.value
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
}