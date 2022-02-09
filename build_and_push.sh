#!/bin/bash

timestamp=$(date +%Y%m%d%H%M%S)

IMAGEID_NEW="vnmd/jupyter-remote-desktop-proxy:$timestamp"
IMAGEID_OLD="vnmd/jupyter-remote-desktop-proxy:latest"

docker build . -t $IMAGEID_NEW
docker build . -t $IMAGEID_OLD -f binder/Dockerfile

ROOTFS_OLD=$(docker inspect --format='{{.RootFS}}' $IMAGEID_OLD)
ROOTFS_NEW=$(docker inspect --format='{{.RootFS}}' $IMAGEID_NEW)

if [ "$ROOTFS_OLD" != "$ROOTFS_NEW" ]; then
    echo "Changes found. Pushing new image"
    docker push $IMAGEID_NEW
    echo "FROM vnmd/jupyter-remote-desktop-proxy:$timestamp" > binder/Dockerfile
else
    echo "No changes found. Skip pushing"
fi
