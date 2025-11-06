FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y \
    curl gnupg lsb-release ca-certificates \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
        https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
        > /etc/apt/sources.list.d/docker.list \
  && apt-get update && apt-get install -y docker-ce-cli \
  && curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose \
  && groupadd -f docker && usermod -aG docker jenkins \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

USER jenkins
