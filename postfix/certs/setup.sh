#!/bin/bash

HOSTNAME=HRSEmail
KEYNAME=priv.key
CRTNAME=priv.crt
TEMPNAME=priv.tmpl
PRIV_KEY=${PWD}/${KEYNAME}
PRIV_CRT=${PWD}/${CRTNAME}
PRIV_TEMP=${PWD}/${TEMPNAME}

# Ensure we are root
if [ ! "`whoami`" = "root" ]; then
	echo "Error: You must be root to run this script!";
	exit 1;
fi
#install certtool
apt-get install gnutls-bin


#clear existing files


#Key generation
if [ -f $PRIV_KEY ]; then 
  echo "CA key already created. Will be updated"
  rm -rf /etc/ssl/certs/${KEYNAME}
  rm -rf $PRIV_KEY
fi
certtool --generate-privkey > $PRIV_KEY

if [ -f $PRIV_CRT ]; then
  echo "CA cert already created. Will be updated"
  rm -rf /etc/ssl/certs/${CRTNAME}
  rm -rf $PRIV_CRT
  sed -i '/cn = /d' $PRIV_TEMP
fi  
echo cn = ${HOSTNAME} >> ${PRIV_TEMP}
certtool --generate-self-signed --load-privkey $PRIV_KEY \
           --template $PRIV_TEMP --outfile $PRIV_CRT


#Copy these two files into certs repository
cp ${PRIV_KEY} /etc/ssl/certs/
cp ${PRIV_CRT} /etc/ssl/certs/

#Update the cert
rm -rf /usr/local/share/ca-certificates/${PRIV_CRT}
cp ${PRIV_CRT} /usr/local/share/ca-certificates/
update-ca-certificates

#Update the hostname
sed -i "/${HOSTNAME}/d" /etc/hosts
echo "127.0.0.1  ${HOSTNAME}" >> /etc/hosts
