# using pass

- `pass github/testaccount -c` copy to clipboard

- `export API_KEY=$(pass github/api_key)` stores the key/password to a
  variable, nice way to pass creds to programs

- `alias aws="AWS_ACCESS_KEY_ID=$(pass show aws/access_id) AWS_SECRET_ACCES_KEY=$(pass show aws/access_token) aws"`
  create a command alias to use the key effectively in cli

# install pass

- `brew install pass` macos
- `apt install pass` ubuntu

# setup

- `gpg --gen-key` generates new keys

- `gpg -K` show master key

# initialize the password store

- `pass init xyz` xyz = master key from `gpg -K` command

# trust key

- `gpg --edit-key xyz` where xyz is the gpg key from `gpg -K`

# reset terminal

reset terminal
`stty sane`

# charaters can be controlled via the PASSWORD_STORE_CHARACTER_SET variable

```bash

export PASSWORD_STORE_CHARACTER_SET='[:alnum:].,!&*%_~$#^@{}[]()<>|=/\+-'
# dash `-` should go last to avoid nasties

```
