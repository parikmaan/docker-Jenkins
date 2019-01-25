#!/usr/bin/env bash

#check your ports are free
#sudo lsof -i tcp:10000 &&  sudo lsof -i tcp:10001

#IP=$(ifconfig en0 | awk '/ *inet /{print $2}')
IP="10.0.0.225"
#echo "Host ip: ${IP}"

# GET PORT IN USE
function getContainerPort() {
    echo $(docker port $1 | sed 's/.*://g')
}

# PULL DOCKER IMAGES
docker pull jenkins/jenkins:lts
docker pull sonarqube:lts
docker pull docker.bintray.io/jfrog/artifactory-oss:6.7.0

if [ ! -d downloads ]; then
    mkdir downloads
    curl -o downloads/jdk-8u144-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-8u144-linux-x64.tar.gz
    curl -o downloads/jdk-7u80-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-7u80-linux-x64.tar.gz
    curl -o downloads/apache-maven-3.5.2-bin.tar.gz http://mirror.vorboss.net/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
fi

if [ ! -d m2deps ]; then
    mkdir m2deps
fi

# STOP DOCKER CONTAINERS
docker stop mysonar myjenkins artifactory 2>/dev/null

docker build --no-cache -t myjenkins .

# START SONAR
docker run -d --rm -p 9000 --name mysonar sonarqube:lts

# START JFROG
docker run -d --rm -p 8081 --name artifactory  docker.bintray.io/jfrog/artifactory-oss:6.7.0

# GET PORTS
sonar_port=$(getContainerPort mysonar)
artifactory_port=$(getContainerPort artifactory)

docker run -d -p 8080 --rm --name myjenkins \
	-v /`pwd`/downloads:/var/jenkins_home/downloads \
    -v /`pwd`/jobs:/var/jenkins_home/jobs/ \
    -v /`pwd`/m2deps:/var/jenkins_home/.m2/repository/ \
    -e SONARQUBE_HOST=http://${IP}:${sonar_port} \
    -e ARTIFACTORY_URL=http://${IP}:${artifactory_port}/artifactory/example-repo-local \
    myjenkins:latest

echo "---------------------------------------------------------"
echo "Sonarqube is running at ${IP}:${sonar_port}"
echo "Artifactory is running at ${IP}:${artifactory_port}"
echo "Jenkins is running at ${IP}:$(getContainerPort myjenkins)"
echo "---------------------------------------------------------"