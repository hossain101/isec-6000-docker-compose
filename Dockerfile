# Base the image on the official Jenkins Long-Term Support release
FROM jenkins/jenkins:lts

# Temporarily switch to root to install system packages
USER root

# Install dependencies, download the Docker repository keys, and install the Docker CLI
RUN apt-get update && apt-get install -y lsb-release curl \
    && curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y docker-ce-cli

# Drop root privileges and revert back to the secure 'jenkins' user
USER jenkins