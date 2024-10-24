#!/bin/bash -eux

export DOT_REINSTALL=true
export DOT_DEBUG=true

. "$(dirname "$0")/_config.sh"

"${DOT_ROOT}/scripts/10_setup_zsh.sh"
