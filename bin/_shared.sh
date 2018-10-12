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

set_instance_type() {
  case $1 in
    "do"|digitalocean)
      export INSTANCE_TYPE=DROPLET
      ;;
    lightsail|aws)
    export INSTANCE_TYPE=LIGHTSAIL
      ;;
    *)
    echo "Unknown cloud provider: $1. Must be 'do' or 'aws'"
    exit 1
    ;;
  esac
}

refresh_terraform() {
  echo "Refreshing terraform outputs"
  ./bin/init > /dev/null 2>&1
  terraform refresh > /dev/null 2>&1
}
