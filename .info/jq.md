# tips

## find any nested key

```sh
terraform show -json | jq '..|.id?' | grep -v 'null'
  "b47dcd42309cc62bae7b275be3d06941b8bbf824"
  "a_buffalo"
```


? = no error/optional

jq .property?

[ {"x" : "this is x"}, {"y" : "this is y"} ]

## colorize while piping to less jq -C | less -R

echo '[ {"x" : "this is x"}, {"y" : "this is y"} ]' | jq -C '.[]' | less -R

## instant schema, helps to build filters from unknown

jq -r 'path(..) | map(tostring) | join("/")'

## examples

```sh
# Your example input, shaped similarly to your original inquiry.
$ cat > orig.json <<EOF
{
  "key1" : "value1",
  "key2" : "value2"
}
EOF

# Use the jq tool to walk the map of kv pairs and reshape it
# into the format consul kv import expects.
$ <orig.json jq '. | to_entries | . | map({key:.key, value:(.value| @base64)})' > new.json
$ cat new.json
[
  {
    "key": "key1",
    "value": "dmFsdWUx"
  },
  {
    "key": "key2",
    "value": "dmFsdWUy"
  }
]

# verify the results
$ consul kv import @new.json
Imported: key1
Imported: key2
$ consul kv get -recurse
key1:value1
key2:value2

```
