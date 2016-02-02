TO DO:
1. Some hard coded places need to be changed
2. The generation of tls certificate is working but should be verified.

SET UP:
1. If we want to create an environment with docker, we can use docker-machine, docker-swarm, and docker-compose
2. To create a normal docker machine based on an exsiting box: login to that box change that users privilege as root (change it in the visudo file like "[USERNAME] ALL=(ALL) NOPASSWD:ALL") for all privileges.
3. To create a normal docker machine based on an exsiting box: copy the ssh key to that machine so that we don't need type password to ssh to that machine. Like ssh-copy-id -i [USERNAME]@IP ADDRESS (-i means that the default public key, i.e. ~/.ssh/id_rsa.pub, is used.) 
4. To create a normal docker machine based on an exsiting box: docker-machine create --driver generic --generic-ip-address [IP ADDRESS] --generic-ssh-user [USERNAME] [MACHINENAME]
5. To create a swarm master based on an exsiting box: docker-machine create --driver generic --generic-ip-address [IP ADDRESS] --generic-ssh-user [USERNAME] --swarm --swarm-master --swarm-discovery [TOKEN NUMBER] swarm-master
6. To create a swarm node based on an exsiting box: docker-machine create --driver generic --generic-ip-address [IP ADDRESS] --generic-ssh-user [USERNAME] --swarm --swarm-discovery [TOKEN NUMBER] swarm-node-00
7. To build the docker monitoring system based on docker containers, pull this project, change some hard coded place and run build.sh.
 
