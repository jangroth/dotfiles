#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

echo 'Configuring tmux...'
confirm_binaries "git" "tmux"

cp -f "${DOT_ROOT}/files/tmux/tmux.conf" "$HOME/.tmux.conf"

if tmux list-sessions >/dev/null 2>&1; then
    echo "tmux server is running — reload config with prefix+r or 'tmux source-file ~/.tmux.conf'" >>"$HOME/.dotfiles-notes"
else
    tmux kill-server || true
fi

# update remote dependencies
if [ -n "$DOT_FORCE" ] || [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugins..."
    rm -rf "$HOME/.tmux/plugins/tpm"
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

"$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo "-> tmux setup finished."
