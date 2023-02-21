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
src/redis-cli --cluster create 127.0.0.1:6300 127.0.0.1:6301 127.0.0.1:6302
sleep 1
src/redis-cli --cluster add-node 127.0.0.1:6400 127.0.0.1:6300 --cluster-slave
sleep 1
src/redis-cli --cluster add-node 127.0.0.1:6401 127.0.0.1:6301 --cluster-slave
sleep 1
src/redis-cli --cluster add-node 127.0.0.1:6402 127.0.0.1:6302 --cluster-slave



############## redis cluster slave 2대 구성 ##############
## 참고문서 https://azderica.github.io/01-db-nosql-redis/

src/redis-server redis_6300.conf
src/redis-server redis_6301.conf
src/redis-server redis_6302.conf
src/redis-server redis_6400.conf
src/redis-server redis_6401.conf
src/redis-server redis_6402.conf
src/redis-server redis_6403.conf
src/redis-server redis_6404.conf
src/redis-server redis_6405.conf

src/redis-cli --cluster create 127.0.0.1:6300 127.0.0.1:6301 127.0.0.1:6302

src/redis-cli --cluster add-node 127.0.0.1:6400 127.0.0.1:6300 --cluster-slave
sleep 1
src/redis-cli --cluster add-node 127.0.0.1:6402 127.0.0.1:6301 --cluster-slave
sleep 1
src/redis-cli --cluster add-node 127.0.0.1:6404 127.0.0.1:6302 --cluster-slave
sleep 1
src/redis-cli --cluster add-node 127.0.0.1:6401 127.0.0.1:6300 --cluster-slave
sleep 1
src/redis-cli --cluster add-node 127.0.0.1:6403 127.0.0.1:6301 --cluster-slave
sleep 1
src/redis-cli --cluster add-node 127.0.0.1:6405 127.0.0.1:6302 --cluster-slave
sleep 1

# 클러스터 슬레이브 걸때 6300-6301-6302 순으로 들어감


# 노드 2개 종료
for i in `ps -ef | grep redis-server | grep -v grep | grep -E '6300|6402|6404|6301|6400|6405' | awk '{ print $2 }'`; do kill $i; done
src/redis-server redis_6300.conf
src/redis-server redis_6402.conf
src/redis-server redis_6404.conf
src/redis-server redis_6301.conf
src/redis-server redis_6400.conf
src/redis-server redis_6405.conf

# 노드 1개 종료
for i in `ps -ef | grep redis-server | grep -v grep | grep -E '6302|6401|6403' | awk '{ print $2 }'`; do kill $i; done

src/redis-server redis_6302.conf
src/redis-server redis_6401.conf
src/redis-server redis_6403.conf



# 전체 종료
for i in `ps -ef | grep redis-server | grep -v grep | awk '{ print $2 }'`; do kill $i; done

#6300
#6402
#6404

#6301
#6400
#6405

#6302
#6401
#6403

# redis-stat 실행
java -jar redis-stat-0.4.14.jar localhost:6300 localhost:6301 localhost:6302 localhost:6400 localhost:6401 localhost:6402 localhost:6403 localhost:6404 localhost:6405 --verbose --server=9202


## master 하나만 종료해도 승격이 안되는 문제 있었음
## 도커라 그런지 승격이 안됨 서버에서 확인해봐야 할듯

