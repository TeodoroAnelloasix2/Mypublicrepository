#IAM role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }

}

resource "aws_iam_role" "backend_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "lambda_dynamodb_policy" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:GetItem"
    ]
    resources = [aws_dynamodb_table.users_db_table.arn]
  }
}


resource "aws_iam_role_policy" "lambda_dynamodb" {
  name   = "lambda_dynamodb_policy"
  role   = aws_iam_role.backend_role.id
  policy = data.aws_iam_policy_document.lambda_dynamodb_policy.json
}

# Function
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.js"
  output_path = "${path.module}/lambda/function.zip"
}

# Create lambda function
resource "aws_lambda_function" "users_lambda" {
  function_name = var.lambda_name
  filename      = data.archive_file.lambda_zip.output_path
  handler       = var.lambda_handler
  runtime       = var.programing_engine
  role          = aws_iam_role.backend_role.arn
  code_sha256   = data.archive_file.lambda_zip.output_base64sha256
  environment {
    variables = {

      TABLE_NAME = aws_dynamodb_table.users_db_table.name
      LOG_LEVEL  = "info"
    }
  }
}