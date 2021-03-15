
# set higher priority to override shipped snippets
# my own -> jinja.snippets, all snippets are priorit 0, so adding higher pririty on mine would take
# precedence over the ones shipped

```python
priority 1

snippet forl "Jinja for loop"
{% for ${1} in $2 %}
$0
{% endfor %}
endsnippet
```
