#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0

check() {
    local label="$1"; shift
    if "$@" &>/dev/null; then
        echo "PASS: $label"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $label"
        FAIL=$((FAIL + 1))
    fi
}

# Shell scripts — bash syntax check
for f in "$ROOT"/scripts/*.sh; do
    check "bash -n scripts/$(basename "$f")" bash -n "$f"
done

# Zsh config files
for f in "$ROOT"/files/zsh/zshenv "$ROOT"/files/zsh/zshrc "$ROOT"/files/zsh/zprofile; do
    check "zsh -n files/zsh/$(basename "$f")" zsh -n "$f"
done

# Zsh completions
for f in "$ROOT"/files/zsh/completions/*; do
    check "zsh -n files/zsh/completions/$(basename "$f")" zsh -n "$f"
done

# Shell functions and aliases
for f in "$ROOT"/files/shell/functions/*; do
    check "zsh -n files/shell/functions/$(basename "$f")" zsh -n "$f"
done
check "zsh -n files/shell/aliases" zsh -n "$ROOT/files/shell/aliases"

# JSON
check "json: files/vscode/settings.json" python3 -m json.tool "$ROOT/files/vscode/settings.json"

# TOML
check "toml: files/starship/starship.toml" python3 -c "
import tomllib, sys
with open(sys.argv[1], 'rb') as f:
    tomllib.load(f)
" "$ROOT/files/starship/starship.toml"

# Git config
check "git config: files/git/gitconfig" git config --file "$ROOT/files/git/gitconfig" --list

# Tmux config (skipped if tmux not available)
if command -v tmux &>/dev/null; then
    check "tmux: files/tmux/tmux.conf" tmux -f "$ROOT/files/tmux/tmux.conf" new-session -d -s "lint_$$"
    tmux kill-session -t "lint_$$" 2>/dev/null || true
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
