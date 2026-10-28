#!/usr/bin/env bash
# Setup for the Claude Code cloud environment used by the nightly routine.
set -euo pipefail

sudo apt-get update -y --allow-releaseinfo-change || true

# Base image ships /etc/zsh/zshrc, so zsh-common hits a conffile prompt without these options.
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    -o Dpkg::Options::=--force-confdef \
    -o Dpkg::Options::=--force-confold \
    zsh shfmt shellcheck tmux
