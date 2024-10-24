#!/bin/bash -eux

cd docker
docker build . \
    --tag newdot:latest \
