# dnsmasq (macos)

## services

* run as root (sudo) and it will auto start on reboot

sudo brew services restart dnsmasq

* ~/.data/dnsmasq.conf working file

must specify the right interfaces if there are multiple on the system
or the service will fail to start correctly, this is already set in ~/.data/dnsmasq.conf

interface=en0
interface=lo0


## troubleshoot

sudo brew services stop dnsmasq
sudo /usr/local/Cellar/dnsmasq/2.82/sbin/dnsmasq --no-daemon --log-queries

## view cache stats using dig

   dig +short chaos txt cachesize.bind
   dig +short chaos txt hits.bind
   dig +short chaos txt misses.bind
