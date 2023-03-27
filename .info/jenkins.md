# build jenkins docker image/reuse from jenkins/jenkins:lts

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
