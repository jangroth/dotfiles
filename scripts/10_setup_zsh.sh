#!/bin/sh -e
[ -n "$DOT_DEBUG" ] && set -x

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

echo "$script_path"
echo "$script_dir"

. "$script_dir/_config.sh"

echo 'Configuring zsh...'
confirm_binaries "git" "starship" "zsh" 

mkdir -p "$HOME/.zsh/functions" "$HOME/.zsh/completions"
cp -f "$DOT_ROOT/files/zsh/zprofile" "$HOME/.zprofile"
cp -f "$DOT_ROOT/files/zsh/zshrc" "$HOME/.zshrc"
cp -f "$DOT_ROOT/files/zsh/zshenv" "$HOME/.zshenv"
cp -f "$DOT_ROOT/files/zsh/completions/"* "$HOME/.zsh/completions/"
cp -f "$DOT_ROOT/files/shell/functions/"* "$HOME/.zsh/functions/"
cp -f "$DOT_ROOT/files/shell/aliases" "$HOME/.zsh/aliases"

mkdir -p "$HOME/.config"
cp -f "$DOT_ROOT/files/starship/starship.toml" "$HOME/.config/"

# update remote dependencies
if [ -n "$DOT_REINSTALL" ] || [ ! -d "$HOME/.oh-my-zsh" ]; then
    rm -rf "$HOME/.oh-my-zsh"
    git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.oh-my-zsh/custom/fzf"
    "$HOME/.oh-my-zsh/custom/fzf/install" --all --key-bindings --completion --no-update-rc
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi
