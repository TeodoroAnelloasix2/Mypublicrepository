resource "aws_dynamodb_table" "users_db_table" {
  name           = var.db_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "user_id"
  range_key      = "timestamp"

  attribute {
    name = "user_id"
    type = "S"
  }
  attribute {
    name = "timestamp"
    type = "N"

  }
  attribute {
    name = "username"
    type = "S"
  }
  global_secondary_index {
    name               = "usernameIndex"
    hash_key           = "username"
    read_capacity      = 10
    write_capacity     = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["user_id"]
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

}