#! /bin/bash

IMAGE="xbigtk13x/docker-game-deploy"

docker build -t ${IMAGE} .
if [ ! -z $1 ]; then
    docker push ${IMAGE}
fi
