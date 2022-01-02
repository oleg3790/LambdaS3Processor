resource "aws_sns_topic" "s3_processor_topic" {
  name = "lambda-s3-processor-topic"
}

resource "aws_sns_topic_subscription" "lambda_s3_processor_sub" {
  topic_arn = aws_sns_topic.s3_processor_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.processor_lambda.arn
}