# microtik router commands

/ip firewall connection print where src-address ~"100.64.0.101"
/ip firewall connection print detail where reply-dst-address ~"192.168.1.11:" # include : to filter correctly

# remove connections

/ip firewall connection remove [find where src-address 192.168.1.10]
/ip firewall connection remove [find protocol=udp && dst-address=192.168.250.100 && connection-mark=GAMING ]

