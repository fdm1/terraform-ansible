#! /bin/bash

# usage: in the remote server definition, include the following local-exec provisioner

#   provisioner "local-exec" {
#     command = resources/remote_server_provisioner.sh REMOTE_HOST_TYPE ${self.IP_ADDRESS_VAR}
#   }

source bin/_shared.sh

set_instance_type $1

export ANSIBLE_HOST_KEY_CHECKING=False
export ${INSTANCE_TYPE}_HOST=$2

RED='\033[0;31m'
NC='\033[0m' # No Color
printf ${RED}
./bin/ansible --no-set-hosts playbook ansible/remote-server.yml --limit $1
printf ${NC}
