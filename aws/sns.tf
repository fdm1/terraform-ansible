locals {
  email = "frankmassi@gmail.com"
}

resource "aws_sns_topic" "notify_me_via_email" {
  name         = "notify-me-via-email"
  display_name = "Notify me of things via email"

  provisioner "local-exec" {
    interpreter = ["python3.6", "-c"]

    command = <<EOF
import boto3
import json

sns = boto3.client('sns')
resp = sns.list_subscriptions_by_topic(TopicArn="${self.arn}")
subs = resp.get('Subscriptions') or []

if not any(sub['Protocol'] == 'email' and sub['Endpoint'] == '${local.email}'
           for sub in subs):
  sns.subscribe(TopicArn='${self.arn}', Protocol='email', Endpoint='${local.email}')
EOF
  }
}
