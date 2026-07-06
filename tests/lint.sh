#!/usr/bin/env bash
set -euox pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0

# Fail fast if lint tools are missing — a missing binary would otherwise
# surface as per-file FAILs indistinguishable from real lint problems.
MISSING=()
for tool in zsh shfmt shellcheck python3; do
    command -v "$tool" &>/dev/null || MISSING+=("$tool")
done
if command -v python3 &>/dev/null && ! python3 -c 'import tomllib' &>/dev/null; then
    MISSING+=("python3-tomllib (python >= 3.11)")
fi
if [ "${#MISSING[@]}" -gt 0 ]; then
    echo "lint: missing required tools: ${MISSING[*]} — install them and re-run" >&2
    exit 1
fi

check() {
    local label="$1"
    shift
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

# shfmt — formatting check (.sh files only)
for f in "$ROOT"/scripts/*.sh "$ROOT"/docker/*.sh "$ROOT"/tests/lint.sh; do
    check "shfmt: $(basename "$f")" shfmt -d -i 4 "$f"
done

# static analysis — .sh files only, skipping _config.sh (zsh shebang)
for f in "$ROOT"/scripts/*.sh "$ROOT"/docker/*.sh "$ROOT"/tests/lint.sh; do
    [ "$(basename "$f")" = "_config.sh" ] && continue
    check "shellcheck: $(basename "$f")" shellcheck --exclude=SC1091 "$f"
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
