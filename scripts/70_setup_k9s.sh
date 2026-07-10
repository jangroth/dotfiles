#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

if ! command -v k9s >/dev/null 2>&1; then
    echo 'k9s not found, skipping k9s setup.'
    exit 0
fi

echo 'Configuring k9s...'

if [ "$DOT_OS" = "darwin" ]; then
    k9s_config_dir="$HOME/Library/Application Support/k9s"
elif [ "$DOT_OS" = "linux" ]; then
    k9s_config_dir="$HOME/.config/k9s"
else
    echo "Unsupported OS '$DOT_OS', skipping k9s setup."
    exit 0
fi

mkdir -p "$k9s_config_dir/skins"
cp -f "$DOT_ROOT/files/k9s/config.yaml" "$k9s_config_dir/config.yaml"
cp -f "$DOT_ROOT/files/k9s/skins/nord.yaml" "$k9s_config_dir/skins/nord.yaml"

echo 'Done configuring k9s.'
