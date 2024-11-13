#!/bin/sh -e
[ -n "$DOT_DEBUG" ] && set -x

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

echo "$script_path"
echo "$script_dir"

. "$script_dir/_config.sh"

echo 'Configuring starship...'
confirm_binaries "starship"

mkdir -p "$HOME/.config"
cp -f "$DOT_ROOT/files/starship/starship.toml" "$HOME/.config/"

echo 'Done configuring starship.'