# jinja2 help

### filters

  https://jinja.palletsprojects.com/en/master/templates/

variables in playbook loop are also avalible in templates if they are being used
as part of with_items or loop

server {
    listen 80;
    server_name {{ item.item.host }};

    error_log /var/log/nginx/{{ item.item.log_file }}_error.log;
    access_log /var/log/nginx/{{ item.item.log_file }}_access.log detail;

    location / {
        try_files $uri $uri/index.html $uri.html =404;
    };
}

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
