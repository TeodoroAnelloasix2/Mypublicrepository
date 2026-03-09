resource "aws_api_gateway_rest_api" "users_api" {
  name = "users-api"
}

resource "aws_api_gateway_resource" "users" {
  rest_api_id = aws_api_gateway_rest_api.users_api.id
  parent_id   = aws_api_gateway_rest_api.users_api.root_resource_id
  path_part   = "users"
}

resource "aws_api_gateway_method" "user_post" {
  rest_api_id   = aws_api_gateway_rest_api.users_api.id
  resource_id   = aws_api_gateway_resource.users.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.users_api.id
  resource_id = aws_api_gateway_resource.users.id
  http_method = aws_api_gateway_method.user_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.users_lambda.invoke_arn
}


resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.users_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.users_api.execution_arn}/*/*/*"
}


resource "aws_api_gateway_deployment" "user_api_deploy" {
  depends_on = [aws_api_gateway_integration.lambda_integration]

  rest_api_id = aws_api_gateway_rest_api.users_api.id
}


output "api_url" {
  value = "${aws_api_gateway_deployment.user_api_deploy.rest_api_id}/users"
}