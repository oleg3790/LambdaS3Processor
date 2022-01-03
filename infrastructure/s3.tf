resource "aws_s3_bucket" "processor_source" {
  bucket = "okrysko-lambda-processor-source"
  acl    = "private"

  tags = local.tags
}

resource "aws_s3_bucket_notification" "processor_source_notification" {
  bucket = aws_s3_bucket.processor_source.id

  topic {
    topic_arn     = aws_sns_topic.s3_processor_topic.arn
    events        = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
  }
}