locals {
    lambda_zip_location = "python/dbcall.zip"
}

data "archive_file" "dbcall" {
  type        = "zip"
  source_file = "python/dbcall.py"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "lambda_func" {
  filename      = "${local.lambda_zip_location}"
  function_name = "dbcall"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "dbcall.lambda_handler"
  runtime = "python3.8"
  environment {
    variables = {
      databaseName = "visitorCount"
    }
  }
}