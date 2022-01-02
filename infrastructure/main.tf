resource "aws_iam_role" "processor_role" {
  name                = "lambda-s3-processor-role"
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_basic_policy" {
  role        = aws_iam_role.processor_role.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "processor_lambda" {
  filename      = "../payload/LambdaS3Processor.zip"
  function_name = "LambdaS3Processor"
  role          = aws_iam_role.processor_role.arn
  handler       = "LambdaS3Processor::LambdaS3Processor.Function::FunctionHandler"
  runtime       = "dotnetcore3.1"
}

resource "aws_lambda_permission" "s3_processor_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.processor_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.s3_processor_topic.arn
}