#! /bin/bash

set_remote_hosts() {
  for s in $(terraform output -json | jq -r .host_ips.value | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" ); do
    export $s
  done
}
