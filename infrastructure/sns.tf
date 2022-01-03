resource "aws_sns_topic" "s3_processor_topic" {
  name = "lambda-s3-processor-topic"

  policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:lambda-s3-processor-topic",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.processor_source.arn}"}
        }
    }]
}
EOF

  lambda_success_feedback_role_arn = aws_iam_role.sns_logs_role.arn
  lambda_failure_feedback_role_arn = aws_iam_role.sns_logs_role.arn

  tags = local.tags
}

resource "aws_sns_topic_subscription" "lambda_s3_processor_sub" {
  topic_arn = aws_sns_topic.s3_processor_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.processor_lambda.arn
}

resource "aws_iam_role" "sns_logs_role" {
  name = "lambda-s3-processor-sns-delivery-role"

  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "sns.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "sns_logs_role_policy" {
  name   = "lambda-s3-processor-sns-log-role"
  role   = aws_iam_role.sns_logs_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:PutMetricFilter",
                "logs:PutRetentionPolicy"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}