# settings for custom GPON configuration on ONT

IP address 192.168.20.60
GW: 192.168.20.1 (my ethernet ip)

uci set network.lct.macaddr="48:77:46:42:30:4E"
uci commit network.lct.macaddr="48:77:46:42:30:4E"
uci set network.host.macaddr="48:77:46:42:32:4E"
uci commit network.host.macaddr="48:77:46:42:32:4E"
uci commit
reboot
