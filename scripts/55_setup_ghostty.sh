#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

echo 'Configuring ghostty...'
confirm_binaries "ghostty"

mkdir -p "$HOME/.config/ghostty"
cp -f "$DOT_ROOT/files/ghostty/config" "$HOME/.config/ghostty/config"

echo 'Done configuring ghostty.'
