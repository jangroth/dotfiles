#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

echo 'Configuring neovim...'
confirm_binaries "git" "nvim"

mkdir -p "$HOME/.config/nvim"
cp -f "${DOT_ROOT}/files/nvim/init.lua" "$HOME/.config/nvim/init.lua"

echo "-> neovim setup finished."
