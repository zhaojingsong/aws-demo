terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Owner        = "Jingsong"
      Project     = "aws-demo"
    }
  }
}


provider "aws" {
  alias = "virginia"
  region = "us-east-1"
  default_tags {
    tags = {
      Owner        = "Jingsong"
      Project     = "aws-demo"
    }
  }
}