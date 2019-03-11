## Dockerized Jenkins [Ubuntu]

Simple setup for running Jenkins using Docker on Ubuntu. Jenkins in the repository is configured with pipeline and docker and other plugins. Combined all this from various sources on internet.

### Goals

- Jenkins running on Docker.
- Use Jenkins to build Docker images. (Utilize Docker on host machine)

### Prerequisites

1. Ubuntu installed on your system

### Steps

1. Clone repository.
1. Download following JDKs from Oracle and copy them to downloads directory:
    1. jdk-8u201-linux-x64.tar.gz
    1. jdk-7u80-linux-x64.tar.gz
1. Run runall.sh to start Jenkins.
1. Login to Jenkins. [Credentials - admin/password]

### Configuration

1. To upgrade or add additional JDKs change javaTools accordingly in groovy/java.groovy.
1. To upgrade or add additional maven versions change mavenToool accordingly in groovy/maven.groovy.
1. Update groovy/mvn_settings.groovy to provide custom maven settings.
1. Update Jenkins security in runall.sh:
    ```
    # Update with actual password
    echo "admin" > ./secrets/jenkinsUsername
    echo "password" > ./secrets/jenkinsPassword
    ```
