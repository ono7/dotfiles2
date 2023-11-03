# AWX deployment notes for kubernetes

## setup external DB

https://www.linkedin.com/pulse/awx-kubernetes-external-db-rajveer-singh/

## enable ip forwarding and fix iptables

```bash
sysctl net.ipv4.ip_forward
sudo sysctl -w net.ipv4.ip_forward=1
sysctl net.bridge.bridge-nf-call-iptables=1
echo "net.ipv4.ip_forward = 1" | sudo tee /etc/sysctl.d/99-ipforward.conf
echo "net.bridge.bridge-nf-call-iptables = 1" | sudo tee /etc/sysctl.d/99-bridge-nf-call-iptables.conf
sudo sysctl -p /etc/sysctl.d/99-ipforward.conf
sudo sysctl -p /etc/sysctl.d/99-bridge-nf-call-iptables.conf
sysctl net.ipv4.ip_forward
```

SELinux Configuration:
You may need to configure SELinux to run in permissive mode, which can be done
by setting SELINUX=permissive in the /etc/selinux/config
