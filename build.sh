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
#Run Prometheus Monitoring system 
docker-compose up -d
