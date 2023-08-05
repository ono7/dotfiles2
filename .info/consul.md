# hashi corp, consul

- used for discovery and load balancing replacement
- uses a registry
- can use its k/v store to store state

# docker

```sh
docker pull consul

docker run \
    -d \
    -p 8500:8500 \
    -p 8600:8600/udp \
    --name=badger \
    consul agent -server -ui -node=server-1 -bootstrap-expect=1 -client=0.0.0.0

docker exec badger consul members

# run consul member server (on new terminal)

docker run \
   --name=fox \
   consul agent -node=client-1 -retry-join=172.17.0.2

```

## consul kv store import/export

```sh
consul kv export > new.json
consul kv import @new.json
```
