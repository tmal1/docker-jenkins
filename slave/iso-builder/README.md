# Ubuntu Docker image with tools to build ISO file
Docker image to run maven

# To run docker in docker you must add this volumes:
- /var/run/docker.sock:/var/run/docker.sock
- /usr/bin/docker:/usr/bin/docker

# You need edit (add) this env:
- JENKINS_USERNAME - username (default empty)
- JENKINS_PASSWORD - password (default empty)
- JENKINS_SLAVE_NAME - slave name (default swarm)
- JENKINS_URL - jenkins url (default 127.0.0.1)
- JENKINS_SLAVE_LABELS - slave label (default empty)
- JENKINS_FS_ROOT - fs root (default empty)
- JENKINS_EXEC_NR - executor number (default 1)
- JENKINS_MODE - normal or exclusive (default exclusive)