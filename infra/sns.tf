resource "aws_sns_topic" "mail_topic" {
  name = "mail-topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.mail_topic.arn
  protocol  = "email"
  endpoint  = "jingsong.fr@gmail.com" 
}