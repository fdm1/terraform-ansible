terraform-ansible
=====================

Personal infrastructure management/playground. Works cross-cloud provider for both AWS and DigitalOcean.

Terraform
=========

Apply the things:

```
$ ./bin/apply
$ ./bin/apply -target=module.aws
$ ./bin/apply -target=module.do
```

If an instance is getting rebuilt, it will re-ansible itself during the apply using a local-exec provisioner.

Ansible
=======

All of these commands will need to know the ansible vault password. They also need to go through the `bin` script, as the host IP for the isntances are determined using the terraform output.

Run the ansible playbook:

```
$ ./bin/ansible playbook ansible/remote-server.yml
$ ./bin/ansible playbook ansible/remote-server.yml --limit lightsail
$ ./bin/ansible playbook ansible/remote-server.yml --limit digitalocean
```

Run other ansible commands:

```
$ ./bin/ansible -m ping
$ bin/ansible -a "echo foo"
$ bin/ansible -a "echo foo" --limit lightsail
$ bin/ansible -a "echo foo" --limit digitalocean
```

Encrypting or editing an encrypted file:

```
$ ansible-vault create path/to/ansible/file/main.yml   # create a file from scratch
$ ansible-vault encrypt path/to/ansible/file/main.yml  # encrypt an unecrypted file
$ ansible-vault edit path/to/ansible/file/main.yml     # edit an encrypted file
$ ansible-vault view path/to/ansible/file/main.yml     # view an encrypted file
$ ansible-vault decrypt path/to/ansible/file/main.yml  # view an encrypted file
```

Secrets are stored using ansible vault, and are automatically decrypted in `./bin/init` to a file that is ignored by git

Encrypting a string via the vault (not using as editing them is almost impossible):

```
$ ansible-vault encrypt_string --ask-vault-pass

# Enter the string, and hit ctrl+d twice.
```

SSH
===

SSH onto the lightsail instance:

```
$ ./bin/ssh <cloud_provider [do|digitalocean, aws|lightsail] (default=do)> <username (default=frankmassi)>
```
