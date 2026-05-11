#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

. "$script_dir/_config.sh"

echo 'Configuring starship...'
confirm_binaries "starship"

mkdir -p "$HOME/.config"
cp -f "$DOT_ROOT/files/starship/starship.toml" "$HOME/.config/"

echo 'Done configuring starship.'
