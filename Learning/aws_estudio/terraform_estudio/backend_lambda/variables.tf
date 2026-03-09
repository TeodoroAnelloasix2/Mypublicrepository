#Dynamo DB vars

variable "db_name" {
  description = "Name of dynamodb table"
  type        = string
}



# Lambda vars

variable "lambda_handler" {
  description = "Handler function"
  type        = string
  default     = "index.handler"
}

variable "lambda_name" {
  description = "Function name"
  type        = string
  default     = "users_lambda_function"
}

variable "programing_engine" {
  type    = string
  default = "nodejs20.x"
}