resource "aws_cloudwatch_metric_alarm" "billing_alert" {
  alarm_name          = "billing_alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "1"
  threshold           = "6"

  actions_enabled   = "true"
  alarm_actions     = ["${aws_sns_topic.notify_me_via_email.arn}"]
  alarm_description = "Let me know when I'm billed anything"

  dimensions {
    Currency = "USD"
  }

  period             = "86400"
  statistic          = "Sum"
  threshold          = "6"
  treat_missing_data = "missing"
}
