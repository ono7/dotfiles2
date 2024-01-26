<!----> TODO: change ltm rules to match on '^ltm rule|ltm next section' @14:09 09-12-21

normal

`^ltm rule .*?(?=^ltm rule|ltm test)`

atomic

`^ltm rule (?>.*?(?=^ltm rule|ltm test))`

slightly better solution

`^ltm rule (?>.*?(?=^ltm \w+))`

<!----> TODO: use jq to filter json @15:09 09-12-21

https://stackoverflow.com/questions/39798542/using-jq-to-fetch-key-value-from-json-output

```json
# test.json
{
  "repositories": [
   {
    "id": "156c48fc-f208-43e8-a631-4d12deb89fa4",
    "namespace": "rhel12",
    "namespaceType": "organization",
    "name": "rhel6.6",
    "shortDescription": "",
    "visibility": "public"
   },
   {
    "id": "f359b5d2-cb3a-4bb3-8aff-d879d51f1a04",
    "namespace": "rhel12",
    "namespaceType": "organization",
    "name": "rhel7",
    "shortDescription": "",
    "visibility": "public"
   }
  ]
 }
```

`cat test.json | jq -r '.repositories[].name'`

> rhel6.6
> rhel7

`cat test.json | jq -r '.repositories[] | "\(.namespace)/\(.name)"'`

> rhel12/rhel6.6
