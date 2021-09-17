resource "aws_iam_role" "processor_role" {
  name                = "lambda-s3-procesor-role"
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
  role        = aws_iam_role.processor_role.arn
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "processor_lambda" {
  filename      = "../payload/LambdaS3Processor.zip"
  function_name = "LambdaS3Processor"
  role          = aws_iam_role.processor_role.arn
  handler       = "FunctionHandler"
  runtime       = "dotnetcore3.1"
}