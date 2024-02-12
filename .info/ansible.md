## aap custom image build

```Dockerfile

FROM rhel-minimal:8-ubi as build

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
# run adhoc commands

`ansible -m shell -a 'ls -loh /home/builder/.vimrc' 'az_agents[0]'`

`az_agents[0]` is a inventory filter

# filers

remove_keys - removes keys from nested dict


```yaml
`{{ data_dict_or_list_of_dicts | remove_keys(target=['test_key', 'test_key2']) }}`
```

## string interpolation supported


```yaml
- name: replace static with delta file
  copy:
    src: "{{ item }}"
    dest: "/usr/share/static"
    backup: yes
  loop: "{{ query('fileglob', '/home/docs/delta.%s' % inventory_hostname) }}"   <<<<<<<<<<<<<<<<<<<<<<



- name: "this is a test"
  hosts: localhost
  gather_facts: false

  vars:
    testing: 1234

  tasks:
    - name: test
      ansible.builtin.debug:
        msg: |
          {{ 'test %s' % testing }}

```
