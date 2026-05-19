#!/bin/bash -eux

cd "$(dirname "$0")"
docker buildx build . \
    --build-arg "USERNAME=$(id -un)" \
    --tag dotfiles:latest
