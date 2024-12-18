#!/bin/sh -e
[ -n "$DOT_DEBUG" ] && set -x

. "$(dirname "$0")/_config.sh"

echo 'Configuring git...'
confirm_binaries "git"

cp -rf "${DOT_ROOT}/files/git/gitconfig" $HOME/.gitconfig

# update remote dependencies
if [ "$DOT_REINSTALL" = "true" ] || [ ! -f "$HOME/.zsh/git-completion.bash" ]; then
    mkdir -p $HOME/.zsh
    curl -LSso $HOME/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    curl -LSso $HOME/.zsh/completions/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

echo "-> git setup finished, use 'git alias' to see configured aliases"
