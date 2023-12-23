#!/bin/bash

# argument 1: Ubuntu version (e.g. 18.04) used as container tag
# argument 2: path to Dockerfile

# docker build --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --tag "dr-yocto" $1

 docker build --no-cache --build-arg "host_uid=$(id -u)"   --build-arg "host_gid=$(id -g)" --tag "cuteradio-image:latest" .
