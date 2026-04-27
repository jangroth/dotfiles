#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

. "$(dirname "$0")/_config.sh"

echo 'Configuring git...'
confirm_binaries "git"

# Read existing user identity before overwriting ~/.gitconfig
_git_name=$(git config --global user.name 2>/dev/null || true)
_git_email=$(git config --global user.email 2>/dev/null || true)

cp -rf "${DOT_ROOT}/files/git/gitconfig" "$HOME/.gitconfig"

# Restore preserved identity; prompt only for values that were not set
if [ -n "$_git_name" ]; then
    git config --global user.name "$_git_name"
fi
if [ -n "$_git_email" ]; then
    git config --global user.email "$_git_email"
fi
if [ -z "$_git_name" ] || [ -z "$_git_email" ]; then
    echo "Git user identity not configured."
    if [ -z "$_git_name" ]; then
        printf "  Enter your git user.name (leave blank to skip): "
        read -r _input_name
        [ -n "$_input_name" ] && git config --global user.name "$_input_name"
    fi
    if [ -z "$_git_email" ]; then
        printf "  Enter your git user.email (leave blank to skip): "
        read -r _input_email
        [ -n "$_input_email" ] && git config --global user.email "$_input_email"
    fi
fi

# update remote dependencies
if [ -n "$DOT_FORCE" ] || [ ! -f "$HOME/.zsh/git-completion.bash" ]; then
    mkdir -p "$HOME/.zsh"
    curl -LSso "$HOME/.zsh/git-completion.bash" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    curl -LSso "$HOME/.zsh/completions/_git" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

echo "-> git setup finished, use 'git alias' to see configured aliases"
