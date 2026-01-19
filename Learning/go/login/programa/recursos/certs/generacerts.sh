#!/bin/bash

set -e

openssl req -newkey rsa:4096 \
    -nodes -sha256 -keyout gologin.key \
    -x509 -days 365 \
    -out gologin.crt \
    -subj "/CN=ctn-gologin/C=ES/ST=BCN/L=Barcelona/O=italianodev/OU=italianodev" \
    -addext "subjectAltName = DNS:ctn-gologin"