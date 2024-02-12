# custom image for aap

1. runs python 3.11
2. runs other tools needed for builds etc

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
