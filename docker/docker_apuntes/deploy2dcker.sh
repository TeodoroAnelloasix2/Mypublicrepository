#!/bin/bash
dockerd -H unix:///var/run/docker-desa.sock  -p /var/run/docker-desa.pid --iptables=false --ip-masq=false --bridge=br-41ec65ed30f7 --data-root=/var/lib/docker-desa --exec-root=/var/run/docker-desa  
