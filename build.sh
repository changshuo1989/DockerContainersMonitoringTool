#!/bin/bash

# Ensure we are root - XXX - this won't respect your docker group
if [ ! "`whoami`" = "root" ]; then
	echo "Error: You must be root to run this script!";
	exit 1;
fi

# Create self-signed key and certs
${PWD}/postfix/certs/setup.sh

#Run Prometheus Monitoring system 

