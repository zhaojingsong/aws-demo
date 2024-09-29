resource "aws_lambda_function" "backend_lambda" {
  function_name = "backend-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"

  s3_bucket = aws_s3_bucket.lambda_bucket.bucket
  s3_key    = "lambda-backend.zip" # This path should be where the zip file is uploaded in S3


  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.my_table.name
    }
  }
  layers     = [aws_lambda_layer_version.nodejs_layer.arn]
  depends_on = [null_resource.upload_lambda]
}

resource "aws_lambda_layer_version" "nodejs_layer" {
  layer_name          = "NodeJsSdkLayer"
  description         = "Node.js SDK Layer for Lambda"
  compatible_runtimes = ["nodejs20.x"]
  source_code_hash    = filebase64sha256("../app/lambda/packages/nodejs.zip")
  filename = "../app/lambda/packages/nodejs.zip"
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

resource "null_resource" "upload_lambda" {
  provisioner "local-exec" {
    command = "aws s3 cp ../app/lambda/packages/lambda-backend.zip s3://${aws_s3_bucket.lambda_bucket.bucket}/lambda-backend.zip"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
