# S3 Bucket for Vue.js frontend without ACL
resource "aws_s3_bucket" "vuejs_frontend" {
  bucket = "my-vuejs-frontend"

}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "lambda-bucket-ef6cacc7"
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.vuejs_frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "null_resource" "upload_file" {
  triggers = {
    always_run = "${timestamp()}"
  }

  # Use local-exec provisioner to run AWS CLI to upload the file to S3
  provisioner "local-exec" {
    command = "aws s3 sync ../dist s3://${aws_s3_bucket.vuejs_frontend.bucket}"
  }
}

resource "aws_s3_bucket_policy" "vuejs_frontend_policy" {
  bucket = aws_s3_bucket.vuejs_frontend.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          "Service" : "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.vuejs_frontend.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.frontend_distribution.id}"
          }
        }
      }
    ]
  })
}
