resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "backend-api"
  description = "API Gateway for the backend Lambda"
}
resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "api"
}
resource "aws_api_gateway_resource" "contact_us" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.api_resource.id
  path_part   = "contact-us"
}

resource "aws_api_gateway_method" "api_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.contact_us.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.contact_us.id
  http_method = aws_api_gateway_method.api_method.http_method
  integration_http_method = "POST"
  type        = "AWS_PROXY"  # Use AWS_PROXY for Lambda integration

  uri = aws_lambda_function.backend_lambda.invoke_arn
}
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [aws_api_gateway_integration.api_integration]
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = "prod"
}

resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.backend_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/*"
}