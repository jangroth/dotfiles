#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

echo "$script_path"
echo "$script_dir"

. "$script_dir/_config.sh"

if [ "$DOT_OS" = "darwin" ]; then
    vscode_user_dir="$HOME/Library/Application Support/Code/User"
elif [ "$DOT_OS" = "linux" ]; then
    vscode_user_dir="$HOME/.config/Code/User"
else
    echo "Unsupported OS '$DOT_OS', skipping vscode setup."
    exit 0
fi

mkdir -p "$vscode_user_dir"
cp -f "$DOT_ROOT/files/vscode/settings.json" "$vscode_user_dir"

echo 'Done configuring vscode.'
