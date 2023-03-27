# passing extra vars to ansible


* passing a file
  ansible-playbook test.yml -e '@test.json'

* passing straight up json
ansible-playbook test.yml -e '{ myvar: "json data through cli"}'

* passing kv pairs

ansible-playbook test.yml -e 'myvar=[1,2,3,3]'
