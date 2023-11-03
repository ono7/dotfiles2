# AWX deployment notes for kubernetes

## setup external DB

https://www.linkedin.com/pulse/awx-kubernetes-external-db-rajveer-singh/

## enable ip forwarding

```bash
sysctl net.ipv4.ip_forward
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" | sudo tee /etc/sysctl.d/99-ipforward.conf
sudo sysctl -p /etc/sysctl.d/99-ipforward.conf
sysctl net.ipv4.ip_forward
```
