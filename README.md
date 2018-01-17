# quorum-docker
Docker for Quorum Blockchain 

## Getting Started

- git clone https://github.com/wangjohnny/quorum-docker
- cd quorum-docker
- docker build -t quorum .

## Using Quorum Docker Image
	docker run -ti --name quorum-instance quorum bash

## Initialize 7 Nodes, start/stop

	root@7cb755d39893:/# cd /quorum-examples/examples/7nodes/
	root@7cb755d39893:/quorum-examples/examples/7nodes# ./raft-init.sh
	root@7cb755d39893:/quorum-examples/examples/7nodes# ./raft-start.sh
	
	stop.sh is not available becasue of killall is not existing in docker
	root@7cb755d39893:/quorum-examples/examples/7nodes# ./stop.sh


### 7 Nodes
Rererence : https://github.com/jpmorganchase/quorum-examples/tree/master/examples/7nodes

### Permissions
Rererence : https://github.com/jpmorganchase/quorum-examples/tree/master/examples/permissions




