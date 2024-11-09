#!/bin/bash -eux

cd docker
docker build . \
    --tag dotfiles:latest \
