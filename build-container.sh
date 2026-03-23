#!/bin/bash -eux

cd docker
docker buildx build . \
    --tag dotfiles:latest \
