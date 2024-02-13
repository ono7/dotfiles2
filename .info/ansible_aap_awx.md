# custom image for aap

Using ansible-builder 3.x and podman

1. podman build

ansible-builder build -t "localhost/mynewthing:development" -v 3 --no-cache --squash all --container-runtime=podman

2. push

podman push aap-hub.company.com/mynewthing:development --tls-verify=false

```execution-environment.yml
---
version: 3

build_arg_defaults:
  ANSIBLE_GALAXY_CLI_COLLECTION_OPTS: "--pre -c"

dependencies:
  ansible_core:
    package_pip: ansible-core==2.16.3
  ansible_runner:
    package_pip: ansible-runner
  python_interpreter:
    package_system: "python311"
    python_path: "/usr/bin/python3.11"
  system:
    - git [platform:rpm]
    - vim-minimal [platform:rpm]
  galaxy: requirements.yml
  python: requirements.txt

options:
  package_manager_path: /usr/bin/microdnf

additional_build_steps:
  prepend_builder:
    - ENV PKGMGR_OPTS "--nodocs --setopt install_weak_deps=0"

images:
  base_image:
    # name: docker.io/redhat/ubi8:latest
    name: registry.access.redhat.com/ubi8/ubi-minimal:latest
```

```Dockerfile
# docker login registry.redhat.io
FROM registry.access.redhat.com/ubi8/ubi-minimal

USER root

RUN ln -s /usr/bin/microdnf /usr/bin/yum && \
  microdnf update -y && microdnf install python3.11 python3.11-pip --nodocs --setopt install_weak_deps=0 -y && \
  alternatives --set python3 /usr/bin/python3.11 && \
  alternatives --install /usr/bin/pip pip /usr/bin/pip3.11 1 && \
  pip --version

ENV PATH=/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/mi-tec/
```
