#!/bin/sh

openssl genrsa -out ca.key 4096
openssl req -new -nodes -key ca.key -config csrconfig_ca.txt -out ca.csr
openssl req -x509 -nodes -in ca.csr -days 1095 -key ca.key -config certconfig_ca.txt -extensions req_ext -out ca.crt

openssl genrsa -out bumper.key 4096
openssl req -new -nodes -key bumper.key -config csrconfig_bumper.txt -out bumper.csr
openssl x509 -req -in bumper.csr -days 365 -CA ca.crt -CAkey ca.key -extfile certconfig_bumper.txt -extensions req_ext -CAcreateserial -out bumper.crt
