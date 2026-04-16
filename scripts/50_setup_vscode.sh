#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

echo "$script_path"
echo "$script_dir"

. "$script_dir/_config.sh"

mkdir -p "$HOME/Library/Application Support/Code/User"
cp -f "$DOT_ROOT/files/vscode/settings.json" "$HOME/Library/Application Support/Code/User"

echo 'Done configuring vscode.'
