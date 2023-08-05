# jinja2 help

### filters

  https://jinja.palletsprojects.com/en/master/templates/

variables in playbook loop are also avalible in templates if they are being used
as part of with_items or loop

```sh
server {
    listen 80;
    server_name {{ item.item.host }};

    error_log /var/log/nginx/{{ item.item.log_file }}_error.log;
    access_log /var/log/nginx/{{ item.item.log_file }}_access.log detail;

    location / {
        try_files $uri $uri/index.html $uri.html =404;
    };
}
```


```yaml
---
- hosts: localhost
  connection: local
  gather_facts: no
  vars:
    foo: bar
    cops_es_nginx_foo: bar
  tasks:

    - set_fact:
        es_vhost: |
          {% set nginx = {'v': {}} %}
          {% set o = 'cops_es_nginx_' %}
          {% set p = 'corpusops_nginx_' %}
          {% for i, val in vars.items() %}
          {%  if i.startswith(o) %}
          {%    set _ = nginx.v.update({p+o.join(i.split(o)[1:]): val}) %}
          {%  endif %}
          {% endfor %}
          {{ nginx.v | to_json }}
    - debug:
        var: es_vhost

    - include_role:
        name: test
      vars:
        role_vhost: '{{ es_vhost }}'
```

```jinja
{% for host in groups['webservers'] %}
    {% if inventory_hostname in hostvars[host]['ansible_fqdn'] %}
{{ hostvars[host]['ansible_default_ipv4']['address'] }} {{ hostvars[host]['ansible_fqdn'] }} {{ hostvars[host]['inventory_hostname'] }} MYSELF
    {% else %}
{{ hostvars[host]['ansible_default_ipv4']['address'] }} {{ hostvars[host]['ansible_fqdn'] }} jcs-server{{ loop.index }} {{ hostvars[host]['inventory_hostname'] }}
    {% endif %}
{% endfor %}
```
