#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

if ! command -v k9s >/dev/null 2>&1; then
    echo 'k9s not found, skipping k9s setup.'
    exit 0
fi

echo 'Configuring k9s...'

mkdir -p "$HOME/.config/k9s/skins"
cp -f "$DOT_ROOT/files/k9s/config.yaml" "$HOME/.config/k9s/config.yaml"
cp -f "$DOT_ROOT/files/k9s/skins/nord.yaml" "$HOME/.config/k9s/skins/nord.yaml"

echo 'Done configuring k9s.'
