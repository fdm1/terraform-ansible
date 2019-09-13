#! /bin/bash

set_remote_hosts() {
  for s in $(terraform output -json | jq -r .host_ips.value | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" | sed 's/\"//g' | sed 's/\[//g' | sed 's/\]//g'); do
    export $s
  done
}

remote_state_bucket() {
  echo fdm1-default-bucket
}

secrets_file() {
  echo secrets.auto.tfvars
}

set_instance_type() {
  case $1 in
    "do"|digitalocean)
      export INSTANCE_TYPE=digitalocean
      ;;
    lightsail|aws)
    export INSTANCE_TYPE=lightsail
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
