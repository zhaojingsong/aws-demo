# DynamoDB Table for Backend
resource "aws_dynamodb_table" "my_table" {
  name           = "my-dynamodb-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
