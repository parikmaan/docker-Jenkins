# Jenkins
Jenkins using docker

# Installation
1. Clone the repository
2. Build using follwing command:

    docker build -t jenkins-docker .
3. Run following command to start Jenkins:

    docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -d --name docker-jenkins docker-jenkins
