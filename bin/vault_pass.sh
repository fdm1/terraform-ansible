#!/bin/sh

# https://disjoint.ca/til/2016/12/14/encrypting-the-ansible-vault-passphrase-using-gpg/
# vault_passphrase is generated randomly and then encrypted against my yubikeys

# profile is needed, as gpg is actually an alias (in fdm1/frank_dotfiles) that uses the correct keyring for whatever yubikey is plugged in
. ${HOME}/.profile

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

gpg --decrypt ${DIR}/vault_passphrase.gpg
