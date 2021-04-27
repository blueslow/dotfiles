#!/bin/bash

PORT="443"
if [ $# -eq 0 ]; then
    echo "No server given, exiting"
    exit 1
fi
# See
# https://www.cyberciti.biz/faq/find-check-tls-ssl-certificate-expiry-date-from-linux-unix/

SERVER_NAME="$1"
echo  "Checking cert at ${SERVER_NAME} on ${PORT}:"
echo | openssl s_client -servername ${SERVER_NAME} -connect ${SERVER_NAME}:${PORT} | openssl x509 -noout -dates

