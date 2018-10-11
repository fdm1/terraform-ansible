#! /bin/bash

set_remote_hosts() {
  for s in $(terraform output -json | jq -r .host_ips.value | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" ); do
    export $s
  done
}

remote_state_bucket() {
  echo fdm1-default-bucket
}

secrets_file() {
  echo secrets.auto.tfvars
}

get_secrets() {
  aws s3 cp s3://$(remote_state_bucket)/terraform/$(secrets_file) .
}
