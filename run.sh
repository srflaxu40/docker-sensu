#!/bin/bash


# Start Rabbitmq and configure with true-hostname:
service rabbitmq-server start

rabbitmqctl add_vhost /sensu && \
rabbitmqctl add_user sensu secret && \
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*" && \

service sensu-server start
service sensu-api start
service sensu-client start
service uchiwa start

redis-server --daemonize yes

while :
do
  echo "Press [CTRL+C] to stop.."
  sleep 1
done


