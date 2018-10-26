# users-ansible-role
This role is meant to be included anywhere users should be added.

## Adding a new backup user

To add a new backup user, edit the [defaults/main.yml](defaults/main.yml) file
and create a new entry within the `users` key.

ansible-vault edit roles/users/defaults/main.yml

format of users file:

```
---
users:
  - name: username1
    authorized_keys:
      - ssh-rsa SSHKEY1
      - ssh-rsa SSHKEY2
  - name: username2
    shell: /bin/zsh
    authorized_keys:
      - ssh-rsa SSHKEY1
```

