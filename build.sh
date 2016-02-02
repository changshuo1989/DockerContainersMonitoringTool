#!/bin/bash

# Ensure we are root - XXX - this won't respect your docker group
if [ ! "`whoami`" = "root" ]; then
	echo "Error: You must be root to run this script!";
	exit 1;
fi
# Create self-signed key and certs
DIR=${PWD}
cd ${DIR}/postfix/certs/
./setup.sh
cd ${DIR}

#check if docker-compose is installed or not
COMPOSE="`which docker-compose`"
if [ -z ${COMPOSE} ]; then
	PIP="`which pip`"
        if [ -z ${PIP} ]; then
        	apt-get -y install python-pip
        fi
        pip install docker-compose
fi
#Run Prometheus Monitoring system 
docker-compose up -d
