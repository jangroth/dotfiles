#!/bin/sh -eux

export DOT_REINSTALL=true
export DOT_DEBUG=true

. "$(dirname "$0")/_config.sh"

"${DOT_ROOT}/scripts/10_setup_zsh.sh"
"${DOT_ROOT}/scripts/15_setup_starship.sh"
"${DOT_ROOT}/scripts/20_setup_tmux.sh"
"${DOT_ROOT}/scripts/30_setup_vim.sh"
"${DOT_ROOT}/scripts/40_setup_git.sh"
"${DOT_ROOT}/scripts/10_setup_vscode.sh"