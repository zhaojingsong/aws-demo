resource "aws_cloudfront_distribution" "frontend_distribution" {
  aliases = [var.domain_name]

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "FR"]
    }
  }
  origin {
    domain_name              = aws_s3_bucket.vuejs_frontend.bucket_regional_domain_name
    origin_id                = "S3-Frontend"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  origin {
    domain_name = "${aws_api_gateway_rest_api.api_gateway.id}.execute-api.${var.aws_region}.amazonaws.com"
    origin_id   = "APIGatewayBackend"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-Frontend"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  ordered_cache_behavior {
    //TODO Add custom domain mapping to avoid using pattern /prod/api/
    path_pattern     = "/prod/api/*"
    cached_methods   = ["HEAD", "GET", "OPTIONS"]
    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    target_origin_id = "APIGatewayBackend"

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.domain_cert.arn
    ssl_support_method        = "sni-only"
    minimum_protocol_version  = "TLSv1.2_2019"
  }
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "MyCloudFrontOAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

