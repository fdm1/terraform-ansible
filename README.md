aws-terraform-ansible
=====================

Terraform
=========

Apply the things:

```
$ ./bin/apply
$ ./bin/apply -target=...
```

If the lightsail instance is getting rebuilt, it will re-ansible itself during the apply.

Ansible
=======

All of these commands will need to know the ansible vault password. They also need to go through the `bin` script, as the host IP for the lightsail isntance is determined using the terraform output.

Run the ansible playbook:

```
$ ./bin/ansible playbook ansible/lightsail_server.yml
```

Run other ansible commands:

```
$ ./bin/ansible -a 'echo hi!'
$ ./bin/ansible -m ping
$ ...
```

SSH
===

SSH onto the lightsail instance:

```
$ ./bin/ssh <username (default=frankmassi)
```
