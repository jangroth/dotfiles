#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

echo "$script_path"
echo "$script_dir"

. "$script_dir/_config.sh"

case "$DOT_OS" in
darwin)
    vscode_config_dir="$HOME/Library/Application Support/Code/User"
    ;;
linux)
    vscode_config_dir="$HOME/.config/Code/User"
    ;;
*)
    echo "Unsupported OS: $DOT_OS — skipping VS Code config."
    exit 0
    ;;
esac

mkdir -p "$vscode_config_dir"
cp -f "$DOT_ROOT/files/vscode/settings.json" "$vscode_config_dir"

echo 'Done configuring vscode.'
