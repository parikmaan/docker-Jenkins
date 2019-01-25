#!/usr/bin/env bash

#Clean anything with same name to get rid of clashes
docker-compose down

docker pull jenkins/jenkins:lts
docker pull sonarqube:lts
docker pull docker.bintray.io/jfrog/artifactory-oss:6.7.0

if [ ! -d downloads ]; then
    mkdir downloads
#    curl -o downloads/jdk-8u131-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-8u131-linux-x64.tar.gz
    curl -o downloads/apache-maven-3.5.0-bin.tar.gz http://apache.mirror.anlx.net/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
fi