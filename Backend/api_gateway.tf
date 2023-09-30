#Cloudwatch Log Group

resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "visitor_count_log_group"
  retention_in_days = 30
}

# API Gateway

resource "aws_apigatewayv2_api" "lambda" {
 	name          = "visitor_count_api"
	protocol_type = "HTTP"
  target        = aws_lambda_function.lambda_func.arn
	description   = "Visitor count for Cloud Resume Challenge"
	cors_configuration {
		allow_origins = ["*"]
	}
}

# API Gateway Stage

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id

  name        = "default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    })
  }

  tags = {
    Name = "Cloud Resume Challenge"
  }
}

# Integration

resource "aws_apigatewayv2_integration" "integration" {
  api_id            = aws_apigatewayv2_api.lambda.id
  integration_type  = "AWS_PROXY"
  integration_method = "POST"
  integration_uri = aws_lambda_function.lambda_func.invoke_arn
}

# API Gateway Route

#resource "aws_apigatewayv2_route" "terraform_lambda_func" {
 # api_id    = aws_apigatewayv2_api.lambda.id
  #route_key = "ANY /terraform_lambda_func"
  #target    = "integrations/${aws_apigatewayv2_integration.integration.id}"
#}

# Permission

resource "aws_lambda_permission" "apigw" {
	action        = "lambda:InvokeFunction"
	function_name = aws_lambda_function.lambda_func.function_name
	principal     = "apigateway.amazonaws.com"
	source_arn    = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}