resource "aws_cloudwatch_metric_alarm" "billing_alert" {
  alarm_name          = "billing_alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  statistic           = "Average"
  period              = "86400"
  threshold           = "6"
  treat_missing_data  = "missing"

  actions_enabled   = "true"
  alarm_actions     = ["${aws_sns_topic.notify_me_via_email.arn}"]
  alarm_description = "Let me know when I'm billed anything"

  dimensions {
    Currency = "USD"
  }
}

resource "aws_budgets_budget" "total_cost" {
  budget_type       = "COST"
  limit_amount      = "6"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2017-07-01_00:00"
  time_unit         = "MONTHLY"
}
