https://scriptingosx.com/2021/04/get-password-from-keychain-in-shell-scripts/

# add password to key chain

> security add-generic-password -s 'CLI Test' -a 'armin' -w 'password123'

# fetch password from keychain

> security find-generic-password -s 'CLI Test' -a 'armin' -w 'password123'

- generic password is also used by ldap, internet password for proxies!
