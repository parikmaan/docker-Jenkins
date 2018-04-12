docker run -d --name docker-jenkins -p 10000:10000 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock docker-jenkins
