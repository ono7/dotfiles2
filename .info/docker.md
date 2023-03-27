# running jenkins/jenkins

* pull from public repo
docker pull jenkins/jenkins

* run it
docker run -p 8080:8080 --name=jenkins-master -d jenkins/jenkins -v
/var/socket

* delete all shutdown containers
docker container prune
