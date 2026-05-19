#!/bin/bash -eux

USERNAME="$(id -un)"
docker run \
    --rm \
    --interactive \
    --tty \
    --volume "$(pwd):/home/${USERNAME}/dotfiles" \
    --hostname dotfiles-test \
    --env DOT_VERBOSE="true" \
    --workdir "/home/${USERNAME}/dotfiles" \
    dotfiles:latest
