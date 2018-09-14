# users-ansible-role
This role is meant to be included anywhere users should be added.

## Adding a new backup user

To add a new backup user, edit the [defaults/main.yml](defaults/main.yml) file
and create a new entry within the `users` key.

### Generating an SSH key

Generate a new RSA keypair (preferrably with 4096 bits and a strong passphrase) and set as the `key`:

    $ ssh-keygen -t rsa -b 4096 -C '[USERNAME]'

### Generating a password

Generate a strong (>25 characters, letters, numbers and symbols) password and set the hashed version
as the `password` key.

You can generate the hashed version of this password by running:

    $ mkpasswd -m sha-512 -S $(openssl rand -hex 8)

`mkpasswd` is provided by the `whois` package on Debian or the `mkpasswd` ruby gem.

### Convert secrets to ansible-vault

For both the ssh key and the password, convert them into ansible-vaulted strings and paste that into the ansible code:

    $ ansible-vault encrypt_string --ask-vault-pass

Enter the string, and hit ctrl+d twice.
