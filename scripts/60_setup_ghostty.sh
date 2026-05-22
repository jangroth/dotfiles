#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

if ! command -v ghostty >/dev/null 2>&1; then
    echo 'ghostty not found, skipping ghostty setup.'
    exit 0
fi

echo 'Configuring ghostty...'

mkdir -p "$HOME/.config/ghostty"
cp -f "$DOT_ROOT/files/ghostty/config" "$HOME/.config/ghostty/config"

echo 'Done configuring ghostty.'
