#!/bin/sh

#Set key and certificate
HOSTNAME=HRSEmail

echo "127.0.0.1 ${HOSTNAME}" >> /etc/hosts
#PRIV_KEY="/opt/certs/priv.key"
#PRIV_CRT="/opt/certs/priv.crt"
#PRIV_TEMP="/opt/certs/priv.tmpl"
#/opt/setup.sh $HOSTNAME $PRIV_KEY $PRIV_CRT $PRIV_TEMP
postconf -e myhostname=${HOSTNAME}
postconf -e smtpd_tls_cert_file=/etc/ssl/certs/priv.crt
postconf -e smtpd_tls_key_file=/etc/ssl/certs/priv.key
postconf -e smtpd_tls_CAfile=/etc/ssl/certs/priv.crt
postconf -e smtpd_tls_CApath=/etc/ssl/certs
#Update certification
cp /etc/ssl/certs/priv.crt /usr/local/share/ca-certificates/
update-ca-certificates
# Set timezone
if [ ! -z "${SYSTEM_TIMEZONE}" ]; then
    echo "configuring system timezone"
    echo "${SYSTEM_TIMEZONE}" > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata
fi

# Set mynetworks for postfix relay
if [ ! -z "${MYNETWORKS}" ]; then
    echo "setting mynetworks = ${MYNETWORKS}"
    postconf -e mynetworks="${MYNETWORKS}"
fi

# General the email/password hash and remove evidence.
if [ ! -z "${EMAIL}" ] && [ ! -z "${EMAILPASS}" ]; then
    echo "[smtp.gmail.com]:587    ${EMAIL}:${EMAILPASS}" > /etc/postfix/sasl_passwd
    postmap /etc/postfix/sasl_passwd
    rm /etc/postfix/sasl_passwd
    echo "postfix EMAIL/EMAILPASS combo is setup."
else
    echo "EMAIL or EMAILPASS not set!"
fi
unset EMAIL
unset EMAILPASS 
