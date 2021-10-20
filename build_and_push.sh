#!/bin/bash

timestamp=$(date +%Y%m%d%H%M%S)

docker build . -t vnmd/jupyter-remote-desktop-proxy:$timestamp
docker push vnmd/jupyter-remote-desktop-proxy:$timestamp

echo "FROM vnmd/jupyter-remote-desktop-proxy:$timestamp" > binder/Dockerfile
