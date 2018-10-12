#! /usr/bin/env sh
cd $(dirname $0)/..

rm -rf .terraform
cp ./ci/resources/ci.auto.tfvars ./ci.auto.tfvars
tfenv install
terraform init -backend=false
terraform validate
