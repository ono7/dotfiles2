# create ansible variable file

~/all.yml

```
---
  ansible_user: my.user
  ansible_ssh_pass: mysecretstuff
```

# encrypt

ansible-vault encrypt ~/all.yml

# use in playbooks with -e "extra variables flag", provide additional vault password file
ansible-playbook backups.yml --vault-password-file ~/secrets.txt -e @~/all.yml


# encrypt inline
ansible-vault encrypt_string --stdin-name 'db_password'

```
ansible-vault encrypt_string --stdin-name 'db_password'
New Vault password:
Confirm New Vault password:
Reading plaintext input from stdin. (ctrl-d to end input) (no return or \n is added)

2132323123123123

some_thing: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          30366230613139363739353365626166353838363936633130373633646534663661656463656664
          6261613861663234613636636133613464346163373432350a303964643265646465343461636366
          36616438663963623333333034386338643765313563353163663433306535383661353231316235
          3137323064633331620a666439623735393733323762333863323734363763366331313361356565
          31643235343536376432646238323063366637346361303764353937393430366237
Encryption successful

```
```python
# vault stub to be used in python code
#!/usr/bin/env python
# if ansible.cfg has path to secrets then it will not require a password
# DEFAULT_VAULT_IDENTITY_LIST
from ansible import constants as C
from ansible.parsing.vault import VaultLib
from ansible.cli import CLI
from ansible.parsing.dataloader import DataLoader

loader = DataLoader()
vault_secret = CLI.setup_vault_secrets(
            loader=loader,
                vault_ids=C.DEFAULT_VAULT_IDENTITY_LIST

        )
vault = VaultLib(vault_secret)
print(vault.decrypt(open('/encrypted_file.txt').read()))
```
