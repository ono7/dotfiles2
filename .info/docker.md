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
