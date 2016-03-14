#!/bin/bash
apt-get update
apt-get install git -y

curl -sSL https://get.docker.com/ > ./docker.sh
sh ./docker.sh
git clone https://github.com/kubernetes/kubernetes
cd ./kubernetes/docs/getting-started-guides/docker-multinode/

if [[ `hostname` =~ .*master.* ]]; then
  export MASTER_IP=`hostname -I | cut -f 1 -d ' '`
  ./master.sh
else
  export MASTER_IP=147.75.194.133
  ./worker.sh
fi
