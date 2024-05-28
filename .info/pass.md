# backup and restore

backup

```sh

cd ~/.password-store
pass git init
pass git add -A .
pass git remote add origin <url>
pass git commit -m "initial commit"
pass git push -u origin master


# get master key

gpg -K

# backup PGP key

gpg --export-secret-keys <master_key> > my-private-key.asc


```

# using pass

- `pass github/testaccount -c` copy to clipboard

- `export API_KEY=$(pass github/api_key)` stores the key/password to a
  variable, nice way to pass creds to programs

- `alias aws="AWS_ACCESS_KEY_ID=$(pass show aws/access_id) AWS_SECRET_ACCES_KEY=$(pass show aws/access_token) aws"`
  create a command alias to use the key effectively in cli

# install pass

- `brew install pass` macos
- `apt install pass` ubuntu

clipboard support in ubuntu needs additional package

`sudo apt install wl-clipboard`

# setup

- `gpg --gen-key` generates new keys

- `gpg -K` show master key

# initialize the password store

- `pass init xyz` xyz = master key from `gpg -K` command

# trust key

- `gpg --edit-key xyz` where xyz is the gpg key from `gpg -K`
  - `trust`
  * change expiration date
    - `expire`

## configure default timeout

create file if not exists

```~/.gnupg/gpg-agent.conf
default-cache-ttl 86400
max-cache-ttl 86400
```

reload agent
`gpg-connect-agent reloadagent /bye`

# reset terminal

reset terminal
`stty sane`

# charaters can be controlled via the PASSWORD_STORE_CHARACTER_SET variable

```bash

export PASSWORD_STORE_CHARACTER_SET='[:alnum:].,!&*%_~$#^@{}[]()<>|=/\+-'
# dash `-` should go last to avoid nasties

```

# macos

```sh
mkdir -m 0700 -p ~/.gnupg
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" | tee ~/.gnupg/gpg-agent.conf
pkill -TERM gpg-agent
```
