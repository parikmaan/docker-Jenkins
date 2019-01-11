FROM jenkins/jenkins:lts

MAINTAINER <Parik Maan>

ENV JENKINS_OPTS --httpPort=10000
EXPOSE 10000

USER root

#RUN mkdir -p /tmp/download && \
# curl -L https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz | tar -xz -C /tmp/download && \
# rm -rf /tmp/download/docker/dockerd && \
# mv /tmp/download/docker/docker* /usr/local/bin/ && \
# rm -rf /tmp/download && \
# groupadd -g 998 docker && \
# usermod -aG staff,docker jenkins

user jenkins
