FROM ruby:2.3.1-slim

RUN apt-get update && \
    apt-get -y install apt-transport-https wget logrotate curl && \
    echo "deb     https://sensu.global.ssl.fastly.net/apt sensu main" | tee /etc/apt/sources.list.d/sensu.list && \
    wget -q https://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | apt-key add - && \
    wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    apt-get -y install erlang-nox=1:18.2 software-properties-common && \
    add-apt-repository "ppa:fkrull/deadsnakes" && \
    wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.0/rabbitmq-server_3.6.0-1_all.deb && \
    dpkg -i rabbitmq-server_3.6.0-1_all.deb && \
    update-rc.d rabbitmq-server defaults && \
    /etc/init.d/rabbitmq-server start && \
    apt-get install -y  sensu uchiwa python2.7 && \
    wget http://download.redis.io/redis-stable.tar.gz && \
    tar xvzf redis-stable.tar.gz && \
    cd redis-stable && \
    make && \
    mkdir -p /usr/bin/ /etc/sensu/handlers /etc/sensu/conf.d/checks/ && \
    chmod 755 /usr/bin && \
    rm /etc/sensu/config.json.example

COPY config.json /etc/sensu/config.json
COPY checks/ /etc/sensu/conf.d/checks/
COPY notification.json /etc/sensu/conf.d/notification.json
COPY handlers/ /etc/sensu/handlers/
COPY handler_notification.json /etc/sensu/conf.d/handler_notification.json
COPY uchiwa.json /etc/sensu/uchiwa.json
COPY run.sh /usr/bin/run.sh

RUN chmod -R 755 /etc/sensu && \
    chown -R sensu:sensu /etc/sensu

CMD /bin/bash /usr/bin/run.sh

EXPOSE 3000

