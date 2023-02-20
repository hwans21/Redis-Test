#!/bin/bash

for list in `ps -ef | grep redis-server | grep -v grep | awk '{ print $2 }'`
do
  kill $list
done
sleep 1
src/redis-server redis_6300.conf
sleep 1
src/redis-server redis_6301.conf
sleep 1
src/redis-server redis_6302.conf
sleep 1
src/redis-server redis_6400.conf
sleep 1
src/redis-server redis_6401.conf
sleep 1
src/redis-server redis_6402.conf
sleep 1
redis-cli --cluster create 127.0.0.1:6300 127.0.0.1:6301 127.0.0.1:6302
sleep 1
redis-cli --cluster add-node 127.0.0.1:6400 127.0.0.1:6300 --cluster-slave
sleep 1
redis-cli --cluster add-node 127.0.0.1:6401 127.0.0.1:6301 --cluster-slave
sleep 1
redis-cli --cluster add-node 127.0.0.1:6402 127.0.0.1:6302 --cluster-slave