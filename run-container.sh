#!/bin/bash -eux

docker run \
    --rm \
    --interactive \
    --tty \
    --volume $(pwd):/home/jan/newdot \
    --hostname newdot-test \
    --env DOT_DEBUG="true" \
    newdot:latest
