# all containers should have this

```Dockerfile
ENV LANG=C.UTF-8
```

# git shell on running container (root)

```sh
docker ps
# get container ID if running container, in this case 5dc47655b035
docker exec -it -u 0 5dc47655b035 /bin/bash

# run other platforms using apple silicon
docker run --rm -it --platform linux/amd64 test.test.com/image-name:dev bash

# -u 0 = root
```

# running jenkins/jenkins

- build with `--cpu-quota xyz`
  `--cpu-quota 10000` 1 cpu 100%
  `--cpu-quota 20000` 2 cpu 100%
  `--cpu-quota 320000` 4 cpu 80%

- pull from public repo
  docker pull jenkins/jenkins

- run it
  docker run -p 8080:8080 --name=jenkins-master -d jenkins/jenkins -v
  /var/socket

- delete all shutdown containers
  docker container prune
