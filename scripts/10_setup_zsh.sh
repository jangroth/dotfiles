#!/bin/sh -e
[ -n "$DOT_VERBOSE" ] && set -x

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

echo "$script_path"
echo "$script_dir"

. "$script_dir/_config.sh"

echo 'Configuring zsh...'
if [ "$DOT_OS" = "linux" ]; then
    confirm_binaries "git" "zsh" "fdfind"
else
    confirm_binaries "git" "zsh" "fd"
fi

[ -L "$HOME/.dotfiles-help" ] && rm "$HOME/.dotfiles-help"
mkdir -p "$HOME/.zsh/functions" "$HOME/.zsh/completions" "$HOME/.dotfiles-help"
cp -f "$DOT_ROOT/files/zsh/zprofile" "$HOME/.zprofile"
cp -f "$DOT_ROOT/files/zsh/zshrc" "$HOME/.zshrc"
cp -f "$DOT_ROOT/files/zsh/zshenv" "$HOME/.zshenv"
cp -f "$DOT_ROOT/files/zsh/completions/"* "$HOME/.zsh/completions/"
cp -f "$DOT_ROOT/files/shell/functions/"* "$HOME/.zsh/functions/"
cp -f "$DOT_ROOT/files/shell/aliases" "$HOME/.zsh/aliases"
cp -f "$DOT_ROOT/files/help/"* "$HOME/.dotfiles-help/"
git -C "$DOT_ROOT" log -1 --format="%h %ad" --date=short >"$HOME/.dotfiles-version"

# update remote dependencies
if [ -n "$DOT_FORCE" ] || [ ! -d "$HOME/.oh-my-zsh" ]; then
    rm -rf "$HOME/.oh-my-zsh"
    git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.oh-my-zsh/custom/fzf"
    "$HOME/.oh-my-zsh/custom/fzf/install" --all --key-bindings --completion --no-update-rc
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi
