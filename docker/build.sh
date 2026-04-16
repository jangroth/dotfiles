#!/bin/bash -eux

cd "$(dirname "$0")"
docker buildx build . \
    --tag dotfiles:latest
