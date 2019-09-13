#! /bin/bash

# usage: in the remote server definition, include the following local-exec provisioner

#   provisioner "local-exec" {
#     command = resources/remote_server_provisioner.sh ${self.IP_ADDRESS_VAR}
#   }

PROJECT_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../
RED='\033[0;31m'
NC='\033[0m' # No Color

export ANSIBLE_HOST_KEY_CHECKING=False

LIMIT=all
if [[ $# > 0 ]]; then
  LIMIT=$1
fi

printf ${RED}
${PROJECT_ROOT}/bin/ansible --no-set-hosts playbook ansible/remote-server.yml --limit $LIMIT
printf ${NC}
