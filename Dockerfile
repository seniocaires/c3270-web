FROM node:6

ADD app /opt/app
ADD cron/crontab /etc/cron.d/limpar-processos-cron
ADD cron/limpar-processos.sh /opt/cron/limpar-processos.sh
ADD run/entrypoint /opt/run/entrypoint
ADD run/.profile /opt/run/.profile

RUN echo "deb http://ftp.br.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y c3270 openssh-server cron sshpass \
    && cp /bin/bash /bin/blokedbash \
    && chmod 0644 /etc/cron.d/limpar-processos-cron \
    && /usr/bin/crontab /etc/cron.d/limpar-processos-cron \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "StrictHostKeyChecking no"  >> /etc/ssh/ssh_config \
    && chmod -R o-w /tmp \
    && chmod +x /opt/run/entrypoint \
    && echo "America/Sao_Paulo" > /etc/timezone && rm /etc/localtime && ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
    && cd /opt/app && npm i

EXPOSE 22 80

WORKDIR /opt/app

CMD ["sh", "/opt/run/cmd"]

ENTRYPOINT ["sh","/opt/run/entrypoint"]
