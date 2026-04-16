#!/bin/bash -eux

docker run \
    --rm \
    --interactive \
    --tty \
    --volume "$(pwd):/home/jan/dotfiles" \
    --hostname dotfiles-test \
    --env DOT_VERBOSE="true" \
    --workdir /home/jan/dotfiles \
    dotfiles:latest
