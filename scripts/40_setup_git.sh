#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

echo 'Configuring git...'
confirm_binaries "git"

# Preserve existing user identity before overwriting gitconfig
_git_name=$(git config --global user.name 2>/dev/null || true)
_git_email=$(git config --global user.email 2>/dev/null || true)

cp -rf "${DOT_ROOT}/files/git/gitconfig" "$HOME/.gitconfig"

# Restore previously set identity; prompt when running interactively
if [ -n "$_git_name" ]; then
    git config --global user.name "$_git_name"
elif [ -t 0 ]; then
    printf 'git user.name (leave blank to skip): '
    IFS= read -r _git_name
    [ -n "$_git_name" ] && git config --global user.name "$_git_name"
fi
if [ -n "$_git_email" ]; then
    git config --global user.email "$_git_email"
elif [ -t 0 ]; then
    printf 'git user.email (leave blank to skip): '
    IFS= read -r _git_email
    [ -n "$_git_email" ] && git config --global user.email "$_git_email"
fi

# update remote dependencies
if [ -n "$DOT_FORCE" ] || [ ! -f "$HOME/.zsh/git-completion.bash" ]; then
    mkdir -p "$HOME/.zsh"
    curl -LSso "$HOME/.zsh/git-completion.bash" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    curl -LSso "$HOME/.zsh/completions/_git" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

echo "-> git setup finished, use 'git alias' to see configured aliases"
