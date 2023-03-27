# podman notes

brew install podman

## mount volumes/folders prior to starting the machine

`https://github.com/ansible/vscode-ansible/wiki/macos`


`podman machine init -v src:target`

note default cpu is 1, probably best to add 4 with some memory

podman machine init --cpus=4 --memory=4096 -v $HOME:$HOME 
podman machine start

# https://edofic.com/posts/2021-09-12-podman-m1-amd64/

* ssh into podman machine

podman machine ssh

* setup proxy

sudo -i

`change to use the correct proxy`

* create service file so rpm-ostree uses proxy

```bash
# this might not be needed, http_proxy might get inherited from outside of the container
mkdir -p /etc/systemd/system/rpm-ostreed.service.d
cat > /etc/systemd/system/rpm-ostreed.service.d/http-proxy.conf << EOF
[Service]
Environment="http_proxy=http://172.16.1.61:8080"
EOF

```
* clean up and then install qemu

rpm-ostree cleanup --repomd
rpm-ostree install qemu-user-static

```bash
mkdir /etc/containers/containers.conf.d
cat > /etc/containers/containers.conf.d/arch.conf << EOF
[containers]
env = [
  "QEMU_CPU=max",
]
EOF
```

* reboot, done, **THIS LOSES THE VOLUMES**
* its best to do a poman machines stop/start instead
systemctl reboot

