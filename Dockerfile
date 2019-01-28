FROM jenkins/jenkins:latest

USER root

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common --no-install-recommends

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

RUN apt-get update && apt-get install -y docker-ce supervisor

RUN usermod -aG docker jenkins

RUN usermod -aG root jenkins

RUN su - jenkins

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /home/jenkins && chown jenkins:jenkins -R /home/jenkins

RUN curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose


COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

USER jenkins

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
