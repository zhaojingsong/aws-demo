terraform {
  backend "s3" {
    bucket  = "aws-demo-tfstate-ef6cacc7" # Replace with your actual bucket name
    key     = "aws-demo.tfstate"  # A unique path within the bucket for the state file
    region  = "eu-west-1"         # Replace with your preferred AWS region
    encrypt = true                # Enable encryption at rest
  }
}
