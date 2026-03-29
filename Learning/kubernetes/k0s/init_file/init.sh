#!/bin/bash

# Run controller with k0sctl 
docker run -it --rm --name controller1 \
  --workdir /backup \
  -v ../backup:/backup \
  -v ./k0sctl.yaml:/etc/k0s/k0sctl.yaml \
  -v ../key/ansible_key.pem:/key/ansible_key.pem  \
   k0sctl  backup --config /etc/k0s/k0sctl.yaml