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

Encrypting a string via the vault:

```
$ ansible-vault encrypt_string --ask-vault-pass

# Enter the string, and hit ctrl+d twice.
```

Encrypting or editing an encrypted file:

```
$ ansible-vault edit path/to/ansible/file/main.yml
```

SSH
===

SSH onto the lightsail instance:

```
$ ./bin/ssh <cloud_provider [do|digitalocean, aws|lightsail] (default=do)> <username (default=frankmassi)>
```
