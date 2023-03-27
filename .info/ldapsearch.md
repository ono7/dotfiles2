# search queries

ldapsearch -H ldap://nad1014tdc.us.global.conseto.com -x -W -D "jose.lima@conseto.com" -b "dc=us,dc=global,dc=conseto,dc=com" "(sAMAccountName=jose.lima)" | grep "memberOf"
