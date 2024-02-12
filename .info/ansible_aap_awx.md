# custom image for aap

1. runs python 3.11
2. runs other tools needed for builds etc

```Dockerfile
FROM redhat/ubi8-minimal as build

USER root

RUN microdnf update -y && microdnf install python3.11 python3.11-devel \
  python3.11-pip libffi-devel findutils unzip gcc make which \
  wget glibc-langpack-en glibc-locale-source jq git podman \
  --nodocs --setopt install_weak_deps=0 -y
RUN alternatives --set python3 /usr/bin/python3.11
RUN alternatives --install /usr/bin/pip pip /usr/bin/pip3.11 1
RUN pip install wheel ruff setuptools ansible ansible-lint ansible-builder pytest
ENV PATH=/usr/bin:${PATH}
```
