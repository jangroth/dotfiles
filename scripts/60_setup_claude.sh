#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

echo 'Configuring claude...'
confirm_binaries "claude"

mkdir -p "$HOME/.claude"

cp -f "${DOT_ROOT}/files/claude/settings.json" "$HOME/.claude/settings.json"
cp -f "${DOT_ROOT}/files/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
chmod +x "$HOME/.claude/statusline-command.sh"

cp -rf "${DOT_ROOT}/files/claude/skills" "$HOME/.claude/skills"
cp -rf "${DOT_ROOT}/files/claude/commands" "$HOME/.claude/commands"

echo '-> claude setup finished'
