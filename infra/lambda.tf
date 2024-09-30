resource "aws_lambda_function" "backend_lambda" {
  function_name = "backend-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.lambdaHandler"
  runtime       = "nodejs20.x"

  s3_bucket = aws_s3_bucket.lambda_bucket.bucket
  s3_key    = var.lambda_package 
  source_code_hash = data.aws_s3_bucket_object.latest_lambda_code.etag


  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.mail_topic.arn
      DYNAMODB_TABLE = aws_dynamodb_table.my_table.name
    }
  }
  depends_on = [null_resource.upload_lambda]
}

data "aws_s3_bucket_object" "latest_lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = var.lambda_package
}


# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach policy to allow Lambda to access DynamoDB
resource "aws_iam_role_policy_attachment" "lambda_dynamodb_access" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# IAM Policy to Allow Lambda to Publish to SNS Topic
resource "aws_iam_policy" "lambda_sns_policy" {
  name   = "LambdaPublishToSNS"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sns:Publish",
        Effect = "Allow",
        Resource = aws_sns_topic.mail_topic.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_sns_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_sns_policy.arn
}

resource "null_resource" "upload_lambda" {
  provisioner "local-exec" {
    command = "aws s3 cp ../app/lambda/typescript-lambda/dist/${var.lambda_package} s3://${aws_s3_bucket.lambda_bucket.bucket}/${var.lambda_package}"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
