#!/bin/bash

timestamp=$(date +%Y%m%d%H%M%S)

docker build . -t vnmd/jupyter-remote-desktop-proxy:$timestamp
docker stop neurodesktop
docker rm neurodesktop
docker run --shm-size=1gb -it --privileged --name neurodesktop -p 8888:8888 vnmd/jupyter-remote-desktop-proxy:$timestamp