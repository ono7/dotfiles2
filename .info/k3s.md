# k3s

- includes built in iptables and other userland dependencies
- more secure out of the box
- smaller
- automatic certificate creation/rotation
- built in ingress controller (Traefik)
- includes helm
- good for developement envs, test envs, experiments and learning

## install

`curl -sfL https://get.k3s.io | sh`

## issue with nic offload setting and reaching DNS in RHEL 8

`https://github.com/k3s-io/k3s/issues/5013`

Oh ==> bad udp cksum 0xf1b1 -> 0x521c!, you might be hitting a kernel bug that
affects udp + vxlan when using the offloading feature of the kernel. We saw it
in Ubuntu but thought it was fixed in RHEL ==> rancher/rke2#1541 Could you
please try disabling the offloading in all nodes? Execute this command
`sudo ethtool -K flannel.1 tx-checksum-ip-generic off` and try again
