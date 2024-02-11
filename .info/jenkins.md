# build jenkins docker image/reuse from jenkins/jenkins:lts

# install jenkins apple m1, install docker

```Dockerfile
# Set the base image for the new image
FROM jenkins/jenkins:lts
# sets the current user to root.
# This is necessary bc some of the following commands need root privileges.
USER root
# Update the package list on the image
RUN apt-get update && \
    # Install the packages for adding the Docker repo and installing Docker
    apt-get install -y apt-transport-https \
                       ca-certificates \
                       curl \
                       gnupg2 \
                       software-properties-common && \
    # Download the Docker repository key and add it to the system
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    # Add the Docker repository to the system
    add-apt-repository \
      "deb [arch=arm64] https://download.docker.com/linux/debian \
      $(lsb_release -cs) \
      stable" && \
    # Update the package list again to include the new repository
    apt-get update && \
    # Install the Docker CE package
    apt-get install -y docker-ce && \
    # Add the Jenkins user to the Docker group so the Jenkins user can run Docker commands
    usermod -aG docker jenkins
```

```Dockerfile
# docker compose file
# requires jenkins_vol to store persistant data
# run with docker-compose -f ThisFile up
version: '3'

services:
  jenkins:
    image: jenkins-arm64
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      # mkdir ~/jenkins_vol
      - ~/jenkins_vol:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
```

```sh
# this is not relevant if using docker compose
docker run --rm --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins

# example Jenkinsfiles here
https://github.com/darinpope/jenkins-example-docker
```

## pipelines

```
pipeline {
    environment {
        GOCACHE = "/var/cache/jenkins/.gocache"
    }
    agent { label 'jenkins-agent-cloud-caching' }
    stages {
        stage("setup"){
            steps {
                sh 'mkdir -p $GOCACHE'
            }
        }
        stage("make check") {
            agent { docker reuseNode: true, image: 'golang:1.18.5-buster' }
            steps {
               script {
		           sh 'make clean'
                   sh 'make'
                   sh 'make test'
               }
            }
        }
    }
}
```

## Dockerfiles

tempdir/jenkinsDockerfile

```
FROM jenkins/jenkins:lts
USER root
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates \
    curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg \
    | apt-key add -
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"
RUN apt-get update -qq \
    && apt-get install docker-ce=17.12.1~ce-0~debian -y
```

- create an image called jenkins-docker, this contains docker it self to allow
  containers to be used for testing

docker build -t jenkins-docker -f JenkinsDockerfile .

### run jenkins in docker image named jenkins-docker as container named jenkins-docker-container

docker run -d -p 8080:8080 --name=jenkins-docker-container -v /var/run/docker.sock:/var/run/docker.sock jenkins-docker

### create a project in jenkins, git,

### jenkins build step

```bash
IMAGE_NAME="test-image"
CONTAINER_NAME="test-container"
echo "Check current working directory"
pwd
echo "Build docker image and run container"
docker build -t $IMAGE_NAME .
docker run -d --name $CONTAINER_NAME $IMAGE_NAME
echo "Copy result.xml into Jenkins container"
rm -rf reports; mkdir reports
docker cp $CONTAINER_NAME:/app/reports/result.xml reports/
echo "Cleanup"
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
docker rmi $IMAGE_NAME
```

# RH7 install

- ref:
  https://www.jenkins.io/doc/book/installing/

sudo wget -O /etc/yum.repos.d/jenkins.repo \
 https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo yum install jenkins java-1.8.0-openjdk-devel
