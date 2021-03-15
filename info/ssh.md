# tunneling

ssh -L \*:80:192.168.117.200:80 user@pivothost

\* = bind to all addresses (makes this socket public)
80 = expose this port to the lan
192.168.117.200 = remote host to expose
:80 = remote host port

# create ssh keys

- in alternate directory

  ssh-keygen -t rsa -b 4096 -C "noa_tower@conseto.com" -f ~/tmp/dir/tower

- in current directory

  ssh-keygen -t rsa -b 4096 -C "noa_tower@conseto.com" -f tower
