#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

echo 'Configuring neovim...'
confirm_binaries "git" "nvim"

mkdir -p "$HOME/.config/nvim/lua"
cp -f "${DOT_ROOT}/files/nvim/init.lua" "$HOME/.config/nvim/init.lua"
cp -Rf "${DOT_ROOT}/files/nvim/lua/." "$HOME/.config/nvim/lua/"

echo "-> neovim setup finished."
